Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IaPzM-0000YI-3M for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 23:03:12 -0700
Received: from wa-out-1112.google.com ([209.85.146.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IaPzL-0007wT-Kw
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Sep 2007 23:03:12 -0700
Received: by wa-out-1112.google.com with SMTP id k22so3142203waf
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Tue, 25 Sep 2007 23:03:11 -0700 (PDT)
Message-ID: <ea9232d10709252303w3c372a9exf91a8062b9446aba@mail.gmail.com>
Date: Wed, 26 Sep 2007 08:03:07 +0200
From: "Karol Swietlicki" <karol@freedroid.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] A possible bug in User Mode Linux.
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

Good morning.
I have just switched to a 2.6.23-rc7 host linux kernel, and UML stopped working.
Here is the message that I get:

Kernel panic - not syncing: start_userspace : expected SIGSTOP, got status = 256


I did some research, and it seems like this is not supposed to happen,
and that it might be relating to my VMSPLIT settings. Here are the
interesting bits from my .config:

# CONFIG_VMSPLIT_3G is not set
CONFIG_VMSPLIT_3G_OPT=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_2G_OPT is not set
# CONFIG_VMSPLIT_1G is not set

After setting this back to the default setting (CONFIG_VMSPLIT_3G=y)
the problem went away.
I am afraid I do not know C well enough to submit a patch. I wish I could.
If there is something else I can do to help you, please tell me.

Thank you for writing this bit of software, this is my favourite
virtual machine and I learned a lot by using it.

Karol Swietlicki

-- 
The way of all things alive.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
