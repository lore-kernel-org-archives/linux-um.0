Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATRyw-0007NW-BN
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 12:27:50 -0800
Received: from mail.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ATRyv-0008C7-Lh
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 12:27:49 -0800
Message-ID: <072e01c3bdca$5d5ff8c0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0312081042480.9997-100000@filer.marasystems.com>
Subject: Re: [uml-user] Re: [uml-devel] Workaround for bug #851759 -  SuSE YAST in textmode does not work
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Mon, 8 Dec 2003 21:32:13 +0100
To: Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>, Gerd Knorr <kraxel@bytesex.org>

> Are you running UML in TT or SKAS mode?
I hated TT mode for all the time - for that reason i run SKAS
:)

----- Original Message ----- 
From: "Henrik Nordstrom" <hno@marasystems.com>
To: "roland" <for_spam@gmx.de>
Cc: <user-mode-linux-devel@lists.sourceforge.net>; "uml-user" <user-mode-linux-user@lists.sourceforge.net>; "Gerd Knorr"
<kraxel@bytesex.org>
Sent: Monday, December 08, 2003 10:44 AM
Subject: [uml-user] Re: [uml-devel] Workaround for bug #851759 - SuSE YAST in textmode does not work


> On Mon, 8 Dec 2003, roland wrote:
>
> > digging deeper into yast, i found that yast (fortunately) uses a special
> > "ycp" Scripting language. A menu-entry in yast consinsts of several ycp
> > modules. a module, which loads quite often is the module "Arch.ycp".
> > with that, yast seems to detect, which hardware architecture it`s
> > running on.
>
> Are you running UML in TT or SKAS mode?
>
> Regards
> Henrik
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
> _______________________________________________
> User-mode-linux-user mailing list
> User-mode-linux-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-user
>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
