Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1TyroA-0004Hh-Rs
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Jan 2013 22:31:38 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Tyro8-0004mZ-Uv
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Jan 2013 22:31:38 +0000
Date: Fri, 25 Jan 2013 23:31:28 +0100
From: Richard Weinberger <richard@nod.at>
Message-ID: <20130125233128.41f45688@spider.haslach.nod.at>
In-Reply-To: <CADNZ+wTwFtr5dMhBBQd7jDObe30w3JgnVGk+-kqNiH_j3yw+8A@mail.gmail.com>
References: <CADNZ+wT==gf=MLjeqx5J1Lw3EEmNOmVjWyVrR6jh4QoTM+xoxw@mail.gmail.com>
	<20130108074356.03f539c2@spider.haslach.nod.at>
	<CADNZ+wRfo6W_x4bg4PX7=yDYJ3Y1e6En-+0gHmzNcPKNs3YLkA@mail.gmail.com>
	<CADNZ+wSkpb6uXRrK__xopF1TPVtANXid9AHukSxkWZ3r6ZnvGg@mail.gmail.com>
	<20130108223151.368c5c49@spider.haslach.nod.at>
	<CADNZ+wTwFtr5dMhBBQd7jDObe30w3JgnVGk+-kqNiH_j3yw+8A@mail.gmail.com>
Mime-Version: 1.0
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
Subject: Re: [uml-devel] File corruption with hostfs and GNU Gold linker
To: Tristan Schmelcher <tschmelcher@google.com>
Cc: user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>

Hi!

Am Fri, 25 Jan 2013 14:27:21 -0800
schrieb Tristan Schmelcher <tschmelcher@google.com>:

> Hello again, Richard. Wondering if you have a rough patch that you'd
> like me to try out. If not, I'd be happy to work on the fix if you
> could give me some pointers to where the issue is in the hostfs code.

Not really.
I think it's time to involve some vfs guys.
What I know so far: Writeback of mmap()'ed pages does not happen.
Calling msync() by hand causes the writeback.
The pages get correctly marked as dirty, the bdi code is also sane.

Thanks,
//richard

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

