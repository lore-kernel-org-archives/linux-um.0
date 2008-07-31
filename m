Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KOhfi-0003RG-BF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 16:35:02 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KOhfg-0000E9-S6
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 31 Jul 2008 16:35:02 -0700
Received: by wa-out-1112.google.com with SMTP id j5so487858wah.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 31 Jul 2008 16:35:00 -0700 (PDT)
Message-ID: <cfa94dc20807311635v3dc4b500w4c243674b5f2bc6b@mail.gmail.com>
Date: Thu, 31 Jul 2008 16:35:00 -0700
From: "Ryan Finnie" <ryan@finnie.org>
In-Reply-To: <200808010108.35145.nanardon@nanardon.zarb.org>
MIME-Version: 1.0
Content-Disposition: inline
References: <200808010108.35145.nanardon@nanardon.zarb.org>
Subject: Re: [uml-devel] Running 32bits code on 64bits kernel-uml
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
To: Olivier Thauvin <nanardon@nanardon.zarb.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

2008/7/31 Olivier Thauvin <nanardon@nanardon.zarb.org>:
> I never notice in FAQ or documentation this limitation. Is this normal ? Is
> there any plan to remove this limitation ? Is there a technical problem to
> fix this denying to fix this ?

(Sorry for the repost, I didn't reply to all the first time.)

It's not a problem per se, just a feature that was never implemented
in 64-bit UML.  Jeff has said he's had this on his "to do" list for
awhile now.

RF

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
