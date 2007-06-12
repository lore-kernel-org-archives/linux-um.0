Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HxzTl-0004gl-O9 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jun 2007 23:03:46 -0700
Received: from an-out-0708.google.com ([209.85.132.247])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HxzTk-0007mk-3U
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 11 Jun 2007 23:03:45 -0700
Received: by an-out-0708.google.com with SMTP id b38so403226ana
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 11 Jun 2007 23:03:43 -0700 (PDT)
Message-ID: <9d1b82480706112303j7877b1d7hd492fc88ca902d6a@mail.gmail.com>
Date: Tue, 12 Jun 2007 11:33:43 +0530
From: Pravin <shindepravin@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [uml-user] Hang on FC7 after mounting root filesystem
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
To: Sylvain Beucler <beuc@beuc.net>
Cc: Jeff Dike <jdike@addtoit.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net

On 6/7/07, Sylvain Beucler <beuc@beuc.net> wrote:
> On Wed, May 23, 2007 at 08:34:35AM -0400, Jeff Dike wrote:
> > I figured out what was happening.  FC6 has a broken PTRACE_SYSEMU,
> > resulting in system call interception being completely broken, and
> > init going into an infinite segfault loop.
> >
> > The patch below is a workaround, and fixes it for me.  I would
> > appreciate anyone seeing early boot hangs trying this and let me know
> > what happens.
>
> It works for me as well, it fixes my long-running freeze with FC6.
>
> I compiled UML 2.6.21.3 with and without the check-sysemu patch, on a
> FC6/2.6.18-1.2849.fc6.
>
> Without: hangs at "VFS: mount root (ext3 filesystem) readonly."
> With: works like a charm :)
>
> Thanks,

I had same problem with FC7 and kernel 2.6.21.
It used to hang at "VFS: mount root (ext3 filesystem) readonly."

But after applying the patch from mail by jeff, its working fine.
http://www.mail-archive.com/user-mode-linux-devel@lists.sourceforge.net/msg04838.html

The problem is still persistant in case of Fedora core.
I hope that it will be solved soon.

thanx for patch.
>
> --
> Sylvain
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>

-- 
 Pravin Shinde

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
