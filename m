Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AojYU-0008OM-Js
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 05:28:30 -0800
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AojYU-0006s5-3G
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 05 Feb 2004 05:28:30 -0800
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <20040205131343.GA25575@elte.hu>
Message-ID: <Pine.GSO.4.58.0402051323330.5177@algedi.dur.ac.uk>
References: <20040119082805.GA4412@elte.hu> <Pine.GSO.4.58.0401200008240.6442@altair.dur.ac.uk>
 <20040120002301.GA5708@elte.hu> <Pine.LNX.4.58.0401232125410.8188@vega.dur.ac.uk>
 <Pine.GSO.4.58.0401232342360.24271@altair.dur.ac.uk>
 <Pine.LNX.4.58.0401241215200.21419@vega.dur.ac.uk>
 <200401241820.i0OIKHY3002399@ccure.user-mode-linux.org>
 <Pine.LNX.4.58.0401241923510.27438@vega.dur.ac.uk> <20040205123057.GA23555@elte.hu>
 <Pine.GSO.4.58.0402051236350.5177@algedi.dur.ac.uk> <20040205131343.GA25575@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 5 Feb 2004 13:28:23 +0000 (GMT)
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net, Gerd Knorr <kraxel@bytesex.org>

On Thu, 5 Feb 2004, Ingo Molnar wrote:

> * M A Young <m.a.young@durham.ac.uk> wrote:
>
> > I have a fully booting FC1 image (from a slightly hacked anaconda)
> > with this patch and an additional one to avoid the exec-shield host
> > problems. It still crashes with sleeping process got sig 11 when I try
> > to shut it down.
>
> interesting. The tree i have now is 2.6.2-mm based, which has Jeff's
> latest patch, plus the bits from the combo patch to enable host-skas3.
> What anaconda change did you have to do, and how did you create the
> image? I got the Fedora image by installing it on a box and then copying
> all files to an empty image.

Basically I hacked isys.py so that it knew about uml disks, then did a
network install. See
http://toast.debian.net/~may/umlproject/install.html

	Michael Young


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
