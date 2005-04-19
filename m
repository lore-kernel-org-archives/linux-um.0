Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DNybW-0003IW-6j for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 12:41:50 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DNybT-0000cA-DN for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 19 Apr 2005 12:41:50 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <4B144766191813520D8327A4@Johannes-Formanns-G4.local>
	<200504161857.49991.blaisorblade@yahoo.it>
	<42298CF0A91CA74C36CCECD5@Johannes-Formanns-G4.local>
In-Reply-To: <42298CF0A91CA74C36CCECD5@Johannes-Formanns-G4.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Message-Id: <200504191816.01659.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: memory leak with 2.4.30 and uml-2.4.27-bs2-pre10?
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 19 Apr 2005 18:16:01 +0200
To: Johannes Formann <johannes@formann.de>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 16 April 2005 18:59, Johannes Formann wrote:
> --On 16. April 2005 18:57:49 +0200 Blaisorblade <blaisorblade@yahoo.it>
>
> wrote:
> > On Saturday 16 April 2005 18:33, Johannes Formann wrote:
> >> Hi,
> >>
> >> I've testing your uml-2.4.27-bs2-pre10-patch with 2.4.30, it compiles
> >> fine, but there seems to be a memory-leak.
Hmm, there should not be any difference with 2.4.26-3um/2.4.27-1um (apart the 
hostfs code, which is the one from 2.4.24-1um).
> >> After running a few days a not very heavily loaded guest (only sshd,
> >> exim and rsyn daemon) needs 80 MB of RAM.


> >> $ free -m
> >>              total       used       free     shared    buffers    
> >> cached Mem:            95         93          1          0          1   
> >>       8 -/+ buffers/cache:         83         11
> >> Swap:          131          0        131
> >
> > Post the content of /proc/slabinfo and /proc/meminfo on a such situation
> > for  verification.
>
> $ cat /proc/meminfo
>         total:    used:    free:  shared: buffers:  cached:
> Mem:  99897344 98086912  1810432        0  1740800  8069120
> Swap: 138403840   643072 137760768


> cat /proc/slabinfo

> blkdev_requests     1024   1040     96   26   26    1
This is just a bit high.

Now, here are the culprits
> inode_cache       117046 123102    512 17586 17586    1
> dentry_cache       61074  80580    128 2686 2686    1
This is a lot of allocated memory by these two caches. If this increases over 
time, it's this the cause of the leak. In this case, try not using hostfs (or 
HPPFS, if you use it; it's even less stable than hostfs) and the leak should 
disappear; in this case, I'll know 
it's a hostfs bug.

To calculate the total size, read man slabinfo - I don't remember well which 
columns gives the interesting numbers. It should be like the 2nd * the 3rd 
number... so about 64M for inode_cache and 8M for dentry_cache (which could 
be normal if rsync is used a lot, maybe).

However, before talking about "memory leak", maybe you should trying flushing 
out these caches (by running some kind of memory-intensive process). Even a 
program mallocing and using lots of memory is ok...

> buffer_head         7236   8440     96  211  211    1
A bit high, too (800k). That's related with not flushed datas, IIRC.

> size-32             4796   5537     32   49   49    1
I think this item should be normal... It's just 160k

> >> Have you tested/expericend something like that?

> > No, even because I have not time to do a lot of testing on the 2.4
> > branch...  I'm working mostly on 2.6, and it actually feels better most
> > of the times.

> hmm, sounds like I should consider switching to 2.6 in the near future.
Probably yes, unless you have a very confortable setup currently and problems 
with 2.6.

However, there are also the famous security problems which have not yet been 
fixed well in 2.4.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade





-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
