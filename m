Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aicps-0003Wx-JT for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 09:05:12 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30) id 1Aicps-0006EB-1u
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Jan 2004 09:05:12 -0800
References: <200401130505.i0D55XS4026774@ccure.user-mode-linux.org>
	<200401172009.50449.blaisorblade_spam@yahoo.it>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <200401172009.50449.blaisorblade_spam@yahoo.it>
Message-ID: <87vfn7yikh.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [uml-devel] Re: uml-patch-2.6.0
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
Date: 19 Jan 2004 18:06:06 +0100
To: BlaisorBlade <blaisorblade_spam@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

BlaisorBlade <blaisorblade_spam@yahoo.it> writes:

> Module support fix is trivial, and does not depend on anything controversial, 
> until you don't enable CONFIG_MODVERSIONS. So apply the patch. I've also 
> infos (and some code) about fixing the panic you get on startup with it 
> enabled.

Uhm, no.  Applied and builds for me, but doesn't work, insmod
complains about *plenty* of unknown symbols.

G-02-LinkScriptCleanup.patch removes various ksymtab stuff from
common.lds.S (which is in the RODATA #define these days), that one
looks like it could be needed too to make modules work ...

  Gerd

-- 
"... und auch das ganze Wochenende oll" -- Wetterbericht auf RadioEins


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
