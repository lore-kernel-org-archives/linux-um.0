Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ed0nW-0002bZ-7H for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:36:38 -0800
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]
	helo=grelber.thyrsus.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ed0nV-00065I-Sk
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Nov 2005 23:36:38 -0800
From: Rob Landley <rob@landley.net>
Subject: Re: [uml-devel] [PATCH] Ok, I build x86-64 -skas0,
	and it still segfaults.
References: <200511121936.41697.rob@landley.net>
	<200511152109.26953.rob@landley.net>
	<200511180843.24126.blaisorblade@yahoo.it>
In-Reply-To: <200511180843.24126.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511180136.30434.rob@landley.net>
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
Date: Fri, 18 Nov 2005 01:36:30 -0600
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Friday 18 November 2005 01:43, Blaisorblade wrote:
> On Wednesday 16 November 2005 04:09, Rob Landley wrote:
> > On Monday 14 November 2005 13:40, Blaisorblade wrote:
> > > Anyway, what it's doing could be correct enough to do... except we do
> > > the linking with GCC! So probably we could simply remove that -rlink
> > > altogether (though the documentation would say otherwise).
> >
> > I'm all for better solutions.  I'm just saying what I needed to do to get
> > it to build with what I had.
>
> Ok, clearer: could you try removing altogether that -rlink? I'm trying here
> too right now... will follow up with results.

I believe I tried that already and the error was the same as when it had the 
wrong directory.

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
