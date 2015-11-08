Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZvYbt-0005P4-Bk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 22:38:53 +0000
Received: from mail-ob0-f174.google.com ([209.85.214.174])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZvYbs-00009y-FI
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Nov 2015 22:38:53 +0000
Received: by obbza9 with SMTP id za9so128270281obb.1
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 08 Nov 2015 14:38:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <563F66E2.6060509@brocade.com>
References: <1446994702-21240-1-git-send-email-aivanov@brocade.com>
	<563F66E2.6060509@brocade.com>
Date: Sun, 8 Nov 2015 23:38:46 +0100
Message-ID: <CAFLxGvyCpg3yiYdxZYXBn+GwYTjSECK1bxxQinRFQDQk0j4gSw@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH] Missing includes in start up
To: Anton Ivanov <aivanov@brocade.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Nov 8, 2015 at 4:18 PM, Anton Ivanov <aivanov@brocade.com> wrote:
> Hi Richard,
>
> This is vs your tree, 4.x master branch in linus repo actually has
> sys/resource.h
>
> Pls ignore the patch.

Sorry for the trouble!
I forgot to mention that linux-next is the only valid branch in my tree.
As UML does not have much patch flood I test them locally and push them directly
to linux-next.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

