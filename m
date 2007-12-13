Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2xEy-0006YE-OF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 15:13:16 -0800
Received: from an-out-0708.google.com ([209.85.132.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1J2xEy-0003Ag-3o
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 13 Dec 2007 15:13:16 -0800
Received: by an-out-0708.google.com with SMTP id b38so277009ana.6
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 13 Dec 2007 15:13:15 -0800 (PST)
Message-ID: <ea9232d10712131513l65d1a2adh1a85fba97fcda114@mail.gmail.com>
Date: Fri, 14 Dec 2007 00:13:15 +0100
From: "Karol Swietlicki" <magotari@gmail.com>
In-Reply-To: <47617E3A.2000409@nagafix.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
References: <20071207182146.2b6f5176@mistral.stie>
	<20071208040335.GA21495@c2.user-mode-linux.org>
	<20071209212731.24bd6f01@mistral.stie> <475DB98D.10001@nagafix.co.uk>
	<20071210193441.1161c8ce@mistral.stie>
	<475EDFA7.8020204@nagafix.co.uk>
	<20071211195413.53b122d6@mistral.stie>
	<47617E3A.2000409@nagafix.co.uk>
Subject: Re: [uml-devel] [uml-user] 64 bit host ?
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
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: Jeff Dike <jdike@addtoit.com>, lanas <lanas@securenet.net>, User-mode Linux Kernel Development <user-mode-linux-devel@lists.sourceforge.net>

On 13/12/2007, Antoine Martin <antoine@nagafix.co.uk> wrote:

I follow only one list, uml-devel, so my reply is only based only on
the context that I have from this mail.

> lanas wrote:
> >>> Even then, I'm surely missing something.  The Fedora Core x86_64
> >>> binary is a mere 2 MB.  Shouldn't be a UML-patched kernel about the
> >>> same size ?

It is. In a way.
karol@BlackBox ~/expe $ du linux
22056   linux
karol@BlackBox ~/expe $ strip linux
karol@BlackBox ~/expe $ du linux
1868    linux

> >> Hmmm, not sure.
> >> Looks like the debug info is big indeed.
> >> The config files are available, so you should be able to figure out
> >> what makes it so fat. (frame-pointers?)

Not at all. Actually, as far as I know it is the lack of frame
pointers that makes the code bigger. Either way, it would never make
it bloat extremely.

> > On the other hand, I downloaded today the source code of kernel
> > 2.6.23-something and it was about 45 MB all in all.  Hard to imagine
> > that a compiled kernel would be of the same size, no ?
> Hah, yes. thinking about it, 45MB is a tad excessive!

Not really. The debug information is really plentiful.
Add in a few libraries with static compiling and you have a
monster-sized kernel on your hands.

> Antoine

Karol Swietlicki

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
