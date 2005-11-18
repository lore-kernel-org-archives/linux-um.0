Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0OW-0001pr-2v for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:10:48 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed0OU-0003qk-ID
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:10:48 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] Re: [PATCH 2/4] UML - Eliminate anonymous union and
	clean up symlink lossage
References: <200511172110.jAHLAQoe010199@ccure.user-mode-linux.org>
	<200511180103.29950.rob@landley.net>
In-Reply-To: <200511180103.29950.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180110.35169.rob@landley.net>
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
Date: Fri, 18 Nov 2005 01:10:34 -0600
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, akpm@osdl.org, linux-kernel@vger.kernel.org

On Friday 18 November 2005 01:03, Rob Landley wrote:
> On Thursday 17 November 2005 15:10, Jeff Dike wrote:
> > This gives a name to the anonymous union introduced in
> > skas-hold-own-ldt, allowing to build on a wider range of gccs.
>
> Or narrower range, in the case of Ubuntu "Horny Hedgehog".  2.6.15-rc1
> builds fine by itself, or with just patch 1 in this series, but with patch
> 2...

To clarify, 1, 3 and 4 in this series all build fine for me.  Only patch 2 is 
breaking my build.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
