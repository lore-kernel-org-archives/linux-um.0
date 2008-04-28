Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JqVgE-0001sM-QS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 08:54:14 -0700
Received: from an-out-0708.google.com ([209.85.132.243])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JqVfu-00056c-85
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 28 Apr 2008 08:54:04 -0700
Received: by an-out-0708.google.com with SMTP id b38so1260971ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 28 Apr 2008 08:53:48 -0700 (PDT)
Message-ID: <804dabb00804280853ld50a9f3o333f0f8d46f2a2ea@mail.gmail.com>
Date: Mon, 28 Apr 2008 23:53:48 +0800
From: "Peter Teoh" <htmldeveloper@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] arch/um/Makefile:100: *** missing separator. Stop.
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

What is the following errors:

make defconfig ARCH=um
/sda4/download/linux_linus/linux-2.6/arch/um/Makefile:100: *** missing
separator.  Stop.

I was not able to find anything relevant from Internet, please advise?

Other infor:

/sda4/download/linux_linus/linux-2.6>uname -r
2.6.25-rc9

/sda4/download/linux_linus/linux-2.6>cat include/config/kernel.release
2.6.25-rc9

-- 
Regards,
Peter Teoh

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
