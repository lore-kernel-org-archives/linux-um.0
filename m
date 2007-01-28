Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBHDc-0001AB-JP for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 13:05:44 -0800
Received: from slartibartfast.pa.net ([66.59.111.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBHDa-0003lc-Mh
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Jan 2007 13:05:44 -0800
Date: Sun, 28 Jan 2007 16:03:52 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
In-Reply-To: <Pine.LNX.4.64.0701281447490.3498@sparrow>
Message-ID: <Pine.LNX.4.64.0701281600140.3159@sparrow>
References: <Pine.LNX.4.64.0701281447490.3498@sparrow>
MIME-Version: 1.0
Subject: Re: [uml-devel] Thread (NPTL?) support, 2.6.20-rc5-git3, x86_64,
	reproducible segmentation fault and possible culprit
Reply-To: William Stearns <wstearns@pobox.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Vince Berk <vberk@ists.dartmouth.edu>, William Stearns <wstearns@pobox.com>

Good afternoon, all,

On Sun, 28 Jan 2007, William Stearns wrote:

> 	Vince Berk pointed out what appears to be a thread issue with uml. 
> The "host" command, part of the bind-utils package, uses threads and crashes 
> when asked to do anything more complex than show its help screen:
>
> -bash-3.1# rpm -q bind-libs bind-utils
> bind-libs-9.3.3-0.1.rc3.fc6
> bind-utils-9.3.3-0.1.rc3.fc6
> -bash-3.1# host www.google.com.
> Segmentation fault
>
> 	(strace below)
>
> 	I rebuilt the "bind" rpm (which creates bind-utils and bind-libs) 
> with a one-line change to the spec file, specifically to the configure 
> command:
>
> [wstearns@spamgate SPECS]$ diff -bud bind.spec.orig bind.spec
> --- bind.spec.orig      2006-12-06 09:55:51.000000000 -0500
> +++ bind.spec   2007-01-28 13:13:54.000000000 -0500
> @@ -320,7 +320,7 @@
> %configure \
>        --with-libtool \
>        --localstatedir=/var \
> -       --enable-threads \
> +       --disable-threads \
>        --enable-ipv6 \
>        --with-pic \
>        --with-openssl=/usr \
>
> 	The new packages work just fine inside uml:
>
> -bash-3.1# rpm -e bind-libs bind-utils
> -bash-3.1# rpm -Uvh 
> /home/wstearns/rpm/RPMS/x86_64/bind-libs-9.3.3-0.1.rc3.x86_64.rpm 
> /home/wstearns/rpm/RPMS/x86_64/bind-utils-9.3.3-0.1.rc3.x86_64.rpm
> Preparing...                ###########################################
>   1:bind-libs              ########################################### [
>   2:bind-utils             ########################################### 
> -bash-3.1# host www.google.com.
> www.google.com is an alias for www.l.google.com.
> www.l.google.com has address 64.233.161.99
> www.l.google.com has address 64.233.161.104
> www.l.google.com has address 64.233.161.147
>
> 	The problem is completely reproducible; the root filesystem and 
> kernel at http://ford.stearns.org/uml/ give a crash every time you actually 
> try to look something up with "host".
> 	Should I be talking to the glibc folks about this?

 	As a side note, if I try to bypass thread support per the 
instructions at http://dag.wieers.com/howto/compatibility/ , I get a 
different error (following is with stock "host"):

-bash-3.1# LD_ASSUME_KERNEL=2.4.19 host www.google.com
host: error while loading shared libraries: libnsl.so.1: cannot open 
shared object file: No such file or directory

-bash-3.1# export LD_ASSUME_KERNEL=2.4.19
-bash-3.1# strace -f host www.google.com.
strace: error while loading shared libraries: libc.so.6: cannot open 
shared object file: No such file or directory

 	Both exist:

$ locate libc.so.6
/lib/libc.so.6
/lib/i686/nosegneg/libc.so.6
/lib64/libc.so.6
$ ls -al `locate libc.so.6`
lrwxrwxrwx 1 root root 11 Jan 25 21:20 /lib/i686/nosegneg/libc.so.6 -> 
libc-2.5.so
lrwxrwxrwx 1 root root 11 Jan 25 21:20 /lib/libc.so.6 -> libc-2.5.so
lrwxrwxrwx 1 root root 11 Jan 25 21:20 /lib64/libc.so.6 -> libc-2.5.so
$ ls -al `locate libc-2.5.so`
-rwxr-xr-x 1 root root 1589880 Jan  5 12:39 /lib/i686/nosegneg/libc-2.5.so
-rwxr-xr-x 1 root root 1573504 Jan  5 12:39 /lib/libc-2.5.so
-rwxr-xr-x 1 root root 1672928 Jan  5 12:25 /lib64/libc-2.5.so

 	Cheers,
 	- Bill

---------------------------------------------------------------------------
         "No question; Saudia Arabia comes down hard on public dissent
too, and when it comes to religious freedom... let's just say U.S.
right-wingers who want America to be a "Christian nation" and have their
beliefs become law ought to be forced to spend a month in Saudi Arabia
so they can see how a real theocracy operates. I don't think they'd like
it."
         -- Robin Miller
( http://www.newsforge.com/technology/04/01/16/1551247.shtml )
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
