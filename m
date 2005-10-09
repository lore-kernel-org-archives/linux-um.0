Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EOjoV-0002Qo-TR	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:38:39 -0700
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EOjoY-0003ai-EF
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 09 Oct 2005 15:38:43 -0700
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] slight UML config simplification.
References: <200510081837.26059.rob@landley.net>
	<20051009181143.GA4901@ccure.user-mode-linux.org>
In-Reply-To: <20051009181143.GA4901@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510091738.20804.rob@landley.net>
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
Date: Sun, 9 Oct 2005 17:38:20 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>

On Sunday 09 October 2005 13:11, Jeff Dike wrote:
> On Sat, Oct 08, 2005 at 06:37:25PM -0500, Rob Landley wrote:
> > Since -tt mode is going to go the way of the dodo when -skas0 stabilizies
> > (and -skas0 "works for me"), start making options that only affect -tt
> > mode depend on -tt mode (and group them together).
> >
> > Start with "nesting level".
>
> Applied, thanks.  There's a bunch more that need similar treatment.
>
>     Jeff

My limiting factor is learning what they are. :)

Rob


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
