Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JEouy-0000DM-F5 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jan 2008 08:45:40 -0800
Received: from py-out-1112.google.com ([64.233.166.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JEoux-0006QR-5N
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 15 Jan 2008 08:45:40 -0800
Received: by py-out-1112.google.com with SMTP id f47so2666691pye.20
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 15 Jan 2008 08:45:37 -0800 (PST)
Message-ID: <cfa94dc20801150845w5328dccfn40858663967884bd@mail.gmail.com>
Date: Tue, 15 Jan 2008 08:45:37 -0800
From: "Ryan Finnie" <ryan@finnie.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] IA32_EMULATION support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net

Jeff, the SKAS4 patches are looking good so far, thanks.  This,
combined with the news that Debian will be releasing an
"etch-and-a-half" supported 2.6.24 kernel, has made me start looking
at plans for 64-bit at work.  At the moment there is no 32-bit object
support in x86_64 UML kernels, and of course knowing my luck, the day
we introduce an x86_64 UML guest at work is the day it needs some
32-bit blob or something.  I believe you mentioned on IRC a few months
ago that you once had a semi-working patch to add IA32_EMULATION a
long time ago.  Would this be something you would be willing to work
on again once things settle down?

Thanks
RF

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
