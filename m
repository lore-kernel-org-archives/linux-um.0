Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EHmpS-00061a-1n	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 11:26:54 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EHmpO-0002gj-8E
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Sep 2005 11:26:54 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050920070918.92204.qmail@mail35-142.sinamail.sina.com.cn>
In-Reply-To: <20050920070918.92204.qmail@mail35-142.sinamail.sina.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="gb2312"
Content-Disposition: inline
Message-Id: <200509202025.15447.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: =?gb2312?q?RE=A3=BAFixed_-?= copy_from_user(dest,
	-1,...) hangs in TT mode (was: Re: [um
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
Date: Tue, 20 Sep 2005 20:25:13 +0200
Content-Transfer-Encoding: 8bit
To: luothing@sina.com
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Tuesday 20 September 2005 09:09, luothing@sina.com wrote:
> <pre>Hi:
>     I simply apply the patch, and run new round ltp on TT mode, and found
> most part of problem is disappear, that\'s a real good news.
>     the failure list is:

>         fcntl23
As I specified in a separate mail, that's a host bug too, due to having the 
file already open for writing. Are you a LTP developer like I guessed or I 
understood something wrong?

From the man page:

              F_WRLCK
                     Take out a write lease.  This will cause us to be 
notified when another process opens the
                     file (for reading or writing) or truncates it.  A write 
lease may be  placed  on  a  file
                     only if no other process currently has the file open.

In the current Linux implementation, that becomes "no process, including the 
caller, has the file open for writing".

So fixing the test-case to open the file for reading only, or closing and 
reopening (if O_CREAT is a problem), would make it pass. Not sure it's right, 
but there's no standard for leases IIRC (I'm not at all an expert about this 
though, so correct me please).
>         ioperm* iopl*
Granted
>         nanosleep02    it seems time is not precise
Yes, we'll look at it.
>         setregid02     with note \"setregid(65535, -1) failed (1) but did
> not set the expected errno (22).\"
Fails on the host too (same Linux version).

> >  Patches are attached against 2.6.13 - apply uml-fault-micro-cleanups
> > before the rest. They\'ll be all included in 2.6.13-bs1. Btw, what\'s
> > your name? I\'d like to credit you in the changelog.

> you can call me: LuoXin

> >  I also fixed the modify_ldt01 problem (trivial missing break;), and
> >  modify_ldt02 doesn\'t create host problems here (but it\'s an older
> > release) -

> It maybe relate to my test environment, I use kernel(linux-2.6.9-prep) from
> redhat, when I apply skas3-v8.2 patch, I need to modify some code, which I
> am not sure, and I test this testcase on office kernel linux-2.6.12.1, it
> passed

> </pre>


-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
