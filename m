Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AojJj-00067q-My
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 05:13:15 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1AojJi-0004xa-2N
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 05:13:14 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040205131343.GA25575@elte.hu>
References: <20040119082805.GA4412@elte.hu> <Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk> <20040120002301.GA5708@elte.hu> <Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk> <Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk> <Pine.LNX.4.58.0401241215200.21419@vega.dur.ac.uk> <200401241820.i0OIKHY3002399@ccure.user-mode-linux.org> <Pine.LNX.4.58.0401241923510.27438@vega.dur.ac.uk> <20040205123057.GA23555@elte.hu> <Pine.GSO.4.58.0402051236350.5177@algedi.dur.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0402051236350.5177@algedi.dur.ac.uk>
Subject: [uml-devel] Re: tt mode tls/glibc crash with 2.6 (Was: Re: uml-patch-2.6.0)
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
Date: Thu, 5 Feb 2004 14:13:43 +0100
To: M A Young <m.a.young@durham.ac.uk>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>


* M A Young <m.a.young@durham.ac.uk> wrote:

> > in tt mode, booting up into /bin/bash seems to work fine and simple
> > commands work.
> 
> I have a fully booting FC1 image (from a slightly hacked anaconda)
> with this patch and an additional one to avoid the exec-shield host
> problems. It still crashes with sleeping process got sig 11 when I try
> to shut it down.

interesting. The tree i have now is 2.6.2-mm based, which has Jeff's
latest patch, plus the bits from the combo patch to enable host-skas3. 
What anaconda change did you have to do, and how did you create the
image? I got the Fedora image by installing it on a box and then copying
all files to an empty image.

	Ingo


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
