Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IfICT-0003Ag-GU for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 09:44:53 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IfICR-0000vL-Uj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 09 Oct 2007 09:44:53 -0700
Date: Tue, 9 Oct 2007 12:44:40 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071009164440.GA7505@c2.user-mode-linux.org>
References: <200708191142.57281.toralf.foerster@gmx.de>
	<200710061514.28090.toralf.foerster@gmx.de>
	<20071008150417.GD5279@c2.user-mode-linux.org>
	<200710081759.33242.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <200710081759.33242.toralf.foerster@gmx.de>
Subject: Re: [uml-devel] build error of an UML kernel with 2.6.2x sources
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Mon, Oct 08, 2007 at 05:59:33PM +0200, Toralf F=F6rster wrote:
> I applied your patch and removed that line, the make process now
> stoppes at this point: =


> include/linux/jiffies.h:18:5: warning: "CONFIG_HZ" is not defined
> include/linux/jiffies.h:20:7: warning: "CONFIG_HZ" is not defined
> include/linux/jiffies.h:22:7: warning: "CONFIG_HZ" is not defined

I think your tree is corrupted somehow.  Can you do an mrproper,
defconfig, and full build?

				Jeff

-- =

Work email - jdike at linux dot intel dot com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
