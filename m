Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Au80s-00039f-JL
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 02:36:06 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1Au7mQ-00072s-Sm
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 20 Feb 2004 02:21:11 -0800
References: <E1AgMua-00075F-00@hermes.virtue>
	<20040113175635.GE2673@jaa.iki.fi>
	<1077235841.8412.37.camel@wopr.tektonic.net>
From: Gerd Knorr <kraxel@bytesex.org>
In-Reply-To: <1077235841.8412.37.camel@wopr.tektonic.net>
Message-ID: <87fzd63vn6.fsf@bytesex.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: [uml-devel] Re: [discuss] UML and AMD-64
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
Date: 20 Feb 2004 11:14:37 +0100
Content-Transfer-Encoding: 8bit
To: Matt Ayres <matta@tektonic.net>, user-mode-linux-devel@lists.sourceforge.net

Matt Ayres <matta@tektonic.net> writes:

> Did you use the skas3 patch?  My understand from looking at it is that
> skas3 is written for i386 only, hence you would only be able to run a
> 32-bit kernel.  

It also runs on 64bit kernels, but in tt mode only due to lacking skas
support.

  Gerd

-- 
Es geht darum, daß ein Haufen Scriptkiddies gerade dabei sind, USENET in
Bunt neu zu erfinden, und sie derzeit einen Haufen Fehler neu machen,
die schon seit 20 Jahren nicht mehr Gegenstand der Forschung sind.
	-- Kristian Köhntopp über blogs und blogger


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id56&alloc_id438&op�k
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
