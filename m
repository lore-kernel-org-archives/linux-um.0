Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnDQj-0001Uk-Et for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 02:02:45 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CnDQd-0007NQ-TJ for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 08 Jan 2005 02:02:45 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] synchronous hostfs
References: <27776.1104084973@marajade.sandelman.ottawa.on.ca>
	<200412291906.08122.blaisorblade@yahoo.it>
	<23369.1104380180@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <23369.1104380180@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501042100.32665.blaisorblade@yahoo.it>
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
Date: Tue, 4 Jan 2005 21:00:32 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>

On Thursday 30 December 2004 05:16, Michael Richardson wrote:
> >>>>> "Blaisorblade" == Blaisorblade  <blaisorblade@yahoo.it> writes:
>     >> I'm running 2.4.26-um3.  I happen to be running hostfs with NFS
>     >> underneath.  I get core dumps from my application, and I want to
>     >> gdb them outside of the UML.
>     >>
>     >> I had to switch from core dump to NFS (which seems to fail now)
>     >> to putting them in /tmp (which is ramdisk), and then move them to
>     >> /var/tmp, which is hostfs.
>
>     Blaisorblade> Hmm - were you putting the core dumps inside a hostfs
>     Blaisorblade> mount, right? This has been reported to fail badly
>
>   Yes, previously.
>
>     Blaisorblade> with 2.4.26-3um... the hostfs contained in 2.4.24-1um
>     Blaisorblade> and 2.4.27-1bs (this tree is from me, on my homepage)
>     Blaisorblade> is stable, while the one in 2.4.24-2um and subsequent
>     Blaisorblade> releases isn't.
>
>   I'll try it on my next compile.
>
>     >> Is there some way to defeat the caching that is occuring?  or
>     >> even to just flush it? (other than umount)
>
>     Blaisorblade> Hmmm, I don't know this... probably giving "sync"
>     Blaisorblade> inside UML should work.  I remember that Jeff said
>     Blaisorblade> that he made hostfs asynchronous in those releases on
>     Blaisorblade> purpose (for performance, IIRC), and this is not bad.

>   I actually wonder if there is really any advantage.
When answering I've not discussed this because I wasn't really sure... you can 
read the exact message in the diary page on the website
>   I'd like to be convinced.
The performance problem has shown some times and been analyzed on the MLs, 
only that it happened with UBD... search "bonnie++" and "performance" and you 
should find your answer...

In short, if the UML kernel executes a blocking FS operation, the UML virtual 
machine is locked for a while; what must happen is instead that the operation 
is performed on behalf of the UML kernel while it continues to run... this 
will be indeed possible when we will fully use AIO (the code for this has 
been written by Jeff, I don't know if it already works or not).

>   It seems that for executables,

>   mapping hostfs files straight into the 
> guest address space 

> wouldn't care. 
It's not very clear to me what you mean...

Well, 

1) whether hostfs data are mapped or copied is not related to the 
synchronous/asynchronous question; the idea was born to avoid memory waste 
and double caching by both UML and the host... which happens even if the data 
are clean (is this what you mean by 

> I'd have thought that for stdio 
> things, that any buffering done by guest kernel would be really just
> wasted.
For stdio, there is 0 difference between the host and guest kernel...
> glibc has already buffered pretty much everything... 
Well, the glibc buffer is one little and pretty thing for one application 
only. The kernel buffer can buffer tons of datas, because is shared by the 
system and the kernel knows a lot more things than glibc...

2) the UML kernel *will* anyhow perform some kind of caching... we cannot 
rewrite the VM to allow avoid it.

If there are ideas to solve this problem can be solved in some non-intrusive 
way, they are well accepted... however maybe using mapping from hostfs could 
already solve most problems that are born from this.

>   However, I'd like to be able to turn it off.

This could be done, i.e. some code could be written in the future for that.
For now, both 2.4.27-bs1 and 2.6.9/2.6.9-bb4/2.6.10 don't include the hostfs 
rewrite.

However, note that hostfs has never been really synchronous. Try to do a tail 
-f inside hostfs on the guest and to modify the file on the host... this will 
never succeed on any existing UML.

(It could be done using dnotify/inotify and maybe someone started doing it, 
but that will happen later).
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
