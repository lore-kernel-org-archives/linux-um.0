Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUVHc-0000lI-5R for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 11:43:44 -0700
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BUVHb-0005zi-HR for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 May 2004 11:43:43 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] No of ubd
In-Reply-To: <200405291408.09412.leen.meyer@home.nl>
Message-ID: <Pine.LNX.4.44.0405302040040.27975-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 30 May 2004 20:43:37 +0200 (CEST)
To: Leendert Meyer <leen.meyer@home.nl>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, 29 May 2004, Leendert Meyer wrote:

> Found this in linux/Documentation/kernel-parameters.txt:
> ---8<---8<---8<---
> 	hd=		[EIDE] (E)IDE hard drive subsystem geometry
> 			Format: <cyl>,<head>,<sect>
> ---8<---8<---8<---
> 
> And this in linux/Documentation/ide.txt:
> ---8<---8<---8<---
>  "hdx=cyl,head,sect"	: disk drive is present, with specified geometry
> ---8<---8<---8<---
> 
> Nothing on ubd concerning geometry. Do I need the fake_ide or fakehd 
> parameters in combination with a hdx=C,H,S?

As I said the Linux kernel does nor care about the geometry.

Geometry is only used by fdisk and friends and there you can specify the
geometry interactively. The only reason why there exists a geometry 
concept in Linux is because of DOS/BIOS compatibility reasons and certain 
I/O subsystems who can not address secotors (old IDE is an example and is 
why you have all the horror of hard drive size limitations in old IDE 
systems..)

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
