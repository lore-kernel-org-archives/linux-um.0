Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Iwmb5-0008Az-VL for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 14:38:35 -0800
Received: from nz-out-0506.google.com ([64.233.162.238])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Iwmb2-0003oK-Lw
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Nov 2007 14:38:35 -0800
Received: by nz-out-0506.google.com with SMTP id f1so1860242nzc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 26 Nov 2007 14:38:32 -0800 (PST)
Message-ID: <ea9232d10711261438n7c0c9ddai8da1daf3a619cf2b@mail.gmail.com>
Date: Mon, 26 Nov 2007 23:38:31 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
In-Reply-To: <474B4823.8030609@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <474A9701.4040908@gmail.com>
	<ea9232d10711261247y6c4a929of3fe88338e2ce659@mail.gmail.com>
	<474B4823.8030609@gmail.com>
Subject: Re: [uml-devel] PROC_MM
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
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

> I see, anyway the latest SKAS3 patch I found is from 07-Feb-2007.
> http://www.user-mode-linux.org/~blaisorblade/patches/skas3-2.6/
>
> Where can I get the latest one? When is it going to the mainline?

I'm afraid that I don't know when it is going mainline, if ever. Jeff?

However one thing that I know is that there exist some other patches.
The newest one I saw applied to 2.6.23, on the uml-user mailing list.
It was not enough to give me skas3, /proc/mm would not work right. I
have not checked there for a new version and I don't keep track of
that list. There are also patches on http://uml.nagafix.co.uk/ nearly
at the bottom of the page. I have not tried those, so I cannot comment
on them. Neither of the two patches I mention are official, as far as
I could gather, unless I missed something obivous.

Karol Swietlicki

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
