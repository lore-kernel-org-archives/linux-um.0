Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JtqBQ-00032A-Oq for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 May 2008 13:24:12 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user49219)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JtqBM-0007lg-R1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 May 2008 13:24:12 -0700
References: <4821B5FC.40307@vulnscan.org>
From: Nix <nix@esperi.org.uk>
Date: Wed, 07 May 2008 21:23:58 +0100
In-Reply-To: <4821B5FC.40307@vulnscan.org> (Bram Matthys's message of "Wed,
	07 May 2008 16:00:28 +0200")
Message-ID: <87hcd97ti9.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] umls unresponsive & consuming 100% cpu time
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
To: "Bram Matthys (Syzop)" <syzop@vulnscan.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 7 May 2008, Bram Matthys said:
> Or any help on how to get additional / useful info?

Set

CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y

in your kernel, and recompile. `bt' will then show heaps more info.

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
