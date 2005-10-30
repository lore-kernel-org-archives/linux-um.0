Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EWJjB-0006HZ-BI	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 12:24:29 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EWJj9-0003px-V3
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 30 Oct 2005 12:24:29 -0800
From: Rob Landley <rob@landley.net>
References: <200510300624.38794.rob@landley.net>
	<35fb2e590510300453q520a9ce7ua1d74d7790b3a6b8@mail.gmail.com>
	<20051030151506.GA3354@ccure.user-mode-linux.org>
In-Reply-To: <20051030151506.GA3354@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200510301424.09100.rob@landley.net>
Subject: [uml-devel] Re: What's wrong with tmpfs?
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
Date: Sun, 30 Oct 2005 14:24:08 -0600
To: Jeff Dike <jdike@addtoit.com>
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Sunday 30 October 2005 09:15, Jeff Dike wrote:
> On Sun, Oct 30, 2005 at 12:53:00PM +0000, Jon Masters wrote:
> > On 10/30/05, Rob Landley <rob@landley.net> wrote:
> > > If somebody needs a reproduction sequence, I'm happy to oblige.  In
> > > theory "mount -t tmpfs /mnt /mnt" should do it, but if it was _that_
> > > simple it wouldn't have shipped...
> >
> > I don't see this behaviour on a regular desktop box running 2.6.14.
> > Guess it's UML specific.
>
> Sorry, but wrong.
>
> IIRC, this triggers when you don't have CONFIG_TMPFS enabled.  If you
> don't, you still get it, but you get a version that's only usable
> in-kernel.

Yup.  Not CONFIG_TEMPFS.  My bad.

Rob


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
