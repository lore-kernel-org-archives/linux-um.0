Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BU2Xs-00089s-Ms for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 05:02:36 -0700
Received: from smtpq2.home.nl ([213.51.128.197])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BU2Xs-0002Yr-B1 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 05:02:36 -0700
Received: from [213.51.128.132] (port=45488 helo=smtp1.home.nl)
	by smtpq2.home.nl with esmtp (Exim 4.30) id 1BU2Xr-0005XI-GL
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 14:02:35 +0200
Received: from cc22149-a.groni1.gr.home.nl ([217.121.240.26]:33565
	helo=ws-02.local) by smtp1.home.nl with esmtp (Exim 4.30)
	id 1BU2Xq-0005f7-7e for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 29 May 2004 14:02:34 +0200
From: Leendert Meyer <leen.meyer@home.nl>
Subject: Re: [uml-devel] No of ubd
References: <Pine.LNX.4.44.0405291038140.9729-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0405291038140.9729-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405291408.09412.leen.meyer@home.nl>
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
Date: Sat, 29 May 2004 14:08:09 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Saturday 29 May 2004 10:40, Henrik Nordstrom wrote:
> On Fri, 28 May 2004, Leendert Meyer wrote:
> > I know how to use fdisk. But I need a bit of guidance here. Given *any*
> > partitionsize, what are the appropriate values? Is there a formula for
> > that?
>
> You just need to set some geometry on the disk.. Linux does not care
> what..  The only important matter is that the geometry should add upp to
> the size of your disk (in 512 byte sectors).

Found this in linux/Documentation/kernel-parameters.txt:
---8<---8<---8<---
	hd=		[EIDE] (E)IDE hard drive subsystem geometry
			Format: <cyl>,<head>,<sect>
---8<---8<---8<---

And this in linux/Documentation/ide.txt:
---8<---8<---8<---
 "hdx=cyl,head,sect"	: disk drive is present, with specified geometry
---8<---8<---8<---

Nothing on ubd concerning geometry. Do I need the fake_ide or fakehd 
parameters in combination with a hdx=C,H,S?

Cheers,

Leen


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
