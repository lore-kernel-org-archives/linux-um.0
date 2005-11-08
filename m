Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EZKLL-0005zi-FV for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 19:40:19 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EZKLK-0003nx-61
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Nov 2005 19:40:19 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Does UML 2.6.14 work under x86-64?
References: <200511061723.32848.rob@landley.net>
	<200511071853.40490.rob@landley.net>
	<Pine.LNX.4.62.0511070646180.2799@qnivq.ynat.uz>
In-Reply-To: <Pine.LNX.4.62.0511070646180.2799@qnivq.ynat.uz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511072139.46779.rob@landley.net>
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
Date: Mon, 7 Nov 2005 21:39:46 -0600
To: David Lang <dlang@invendra.net>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

On Monday 07 November 2005 08:47, David Lang wrote:
> >> GCC version?
> >
> > 4.0.2, hacked to link against uClibc.
>
> does it use the GCC you include for the first compile, or the base
> compiler on the host OS?

You're right, building UML is the job of the base compiler in the host OS.

> David Lang

Rob


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
