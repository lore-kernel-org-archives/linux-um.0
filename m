Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1ACE63-00087r-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 22 Oct 2003 01:11:59 -0700
Received: from dsl093-002-214.det1.dsl.speakeasy.net
	([66.93.2.214] helo=pumpkin.fieldses.org ident=mail)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1ACA4P-0004oC-PE
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 21 Oct 2003 20:54:01 -0700
Subject: Re: [uml-devel] Re: uml-patch-2.6.0-test8
Message-ID: <20031022035215.GA4291@fieldses.org>
References: <200310212018.h9LKILeg002739@ccure.karaya.com> <200310212115.h9LLFneg003091@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310212115.h9LLFneg003091@ccure.karaya.com>
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 21 Oct 2003 23:52:16 -0400
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tue, Oct 21, 2003 at 05:15:49PM -0400, Jeff Dike wrote:
> Some moron said:
> > This patch updates UML to 2.6.0-test8.
> > The 2.6.0-test5 UML patch is available at
> > 	http://jdike.stearns.org/mirror/uml-patch-2.6.0-test8.bz2 
> 
> That patch was bogus.  I replaced it with a good one, so pull it again if it
> totally breaks for you.

I downloaded the patch from the URL above; it doesn't seem to have any
hostfs code in it.

Applying the /fs/ parts of the -test5 patch seems to work for
now....--Bruce Fields


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
