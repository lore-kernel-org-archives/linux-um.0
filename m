Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ConJj-0001CH-Ir for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 10:34:03 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1ConJi-0000up-Jb for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jan 2005 10:34:03 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] df -h and hostfs
References: <50806.80.203.0.208.1105530488.squirrel@80.203.0.208>
	<200501121833.03286.blaisorblade@yahoo.it>
	<52224.80.203.0.208.1105554129.squirrel@80.203.0.208>
In-Reply-To: <52224.80.203.0.208.1105554129.squirrel@80.203.0.208>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121936.16890.blaisorblade@yahoo.it>
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
Date: Wed, 12 Jan 2005 19:36:16 +0100
To: stian@nixia.no
Cc: user-mode-linux-devel@lists.sourceforge.net

On Wednesday 12 January 2005 19:22, stian@nixia.no wrote:
> >> df -h inside UML: (/etc/mtab is symlinked to /proc/mounts)
> >>
> >> Filesystems           Size  Used Avail Use% Mounted on
> >> rootfs                496M   11M  460M   3% /
> >> /dev/root             496M   11M  460M   3% /
> >> /dev/ubd/disc1/part1  187G  146G   33G  82% /a
> >> a                     7.3G  6.2G  717M  90% /a/lost+found
> >> /root/UML/a           7.3G  6.2G  717M  90% /a/lost+found
> >
> > What has happened here? Why there are two entries on the same mount
> > point? One
> > mount over the other?

Well, there is a big question - is there in the patchset a "hostfs" or 
"externfs" patch? In that case, if you used the *new* hostfs code, everything 
I said disappears, because that's completely different code.

Only in the other case, you can find below my answer.

> I just used
> mount /root/UML/a /a/lost+found -t hostfs
Hmm, like I supposed. This is the wrong command line. To mount the 
host /root/UML/a, you need to use this syntax:

mount none /a/lost+found -t hostfs -o /root/UML/a

This is the correct syntax.
> why should you need an -o ? The mount-point works, and everything inside
> it looks like it should,

Well, do you claim that it contains only the content of /root/UML/a on the 
host?

I think that this is false, and I just tested this on my UML (2.6.9-bs5):

root@zion:~ (0)# umount /mnt/host/
root@zion:~ (0)# mount /bin/ -t hostfs /mnt/host/
root@zion:~ (0)# ls /mnt/host/
bin/   dev/   etc/   lib/  opt@   root/  sys/  usr/
boot/  disk@  home/  mnt/  proc/  sbin/  tmp/  var/
root@zion:~ (0)# umount /mnt/host/

root@zion:~ (0)# mount none  -t hostfs /mnt/host/ -o /bin
root@zion:~ (0)# ls /mnt/host/
Mail@          df*             install*        pidof@       tar*
root@zion:~ (0)# umount /mnt/host/

Satisfied? If that syntax works on your kernel, something *very* strange is 
happening.
> and files I put into it appears as they should (I 
> used that directory, since the uml-filesystem is just banged together som
> files from /bin so I could fix a disk, use /bin/sh as init for instance)

> An those entries as what likes in /proc/mounts, since I don't have a
> maintained /etc/mtab file in that filesystem. /etc/mtab is symlinked to
> /proc/mounts
Ok, understood, but the duplicate entry still seems a bit strange...

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
