Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AUYlp-0008BP-LP
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Dec 2003 13:54:53 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.24)
	id 1AUYlp-0002xx-4U
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 11 Dec 2003 13:54:53 -0800
Message-ID: <044301c3c032$0789b930$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20031208095906.GB22878@bytesex.org> <Pine.LNX.4.44.0312081233150.10622-100000@filer.marasystems.com> <20031211120056.GA5347@bytesex.org>
Subject: Re: [uml-devel] Re: Workaround for bug #851759 -  SuSE YAST in textmode does not work
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Thu, 11 Dec 2003 22:59:13 +0100
To: Gerd Knorr <kraxel@bytesex.org>, Henrik Nordstrom <hno@marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

mhhh,
that result is different to the results i posted.
what uml on what host are you using?
regards
roland


----- Original Message ----- 
From: "Gerd Knorr" <kraxel@bytesex.org>
To: "Henrik Nordstrom" <hno@marasystems.com>
Cc: "roland" <for_spam@gmx.de>; <user-mode-linux-devel@lists.sourceforge.net>; "uml-user"
<user-mode-linux-user@lists.sourceforge.net>
Sent: Thursday, December 11, 2003 1:00 PM
Subject: Re: [uml-devel] Re: Workaround for bug #851759 - SuSE YAST in textmode does not work


> On Wed, Dec 10, 2003 at 10:14:07PM +0100, Henrik Nordstrom wrote:
> > On Mon, 8 Dec 2003, Gerd Knorr wrote:
> >
> > > IMHO this one is a UML kernel bug.
> >
> > The hang certainly can be considered a UML bug.
> >
> > I think the same hang should be seen on any SIGSEGV due to incorrect X86
> > I/O operations. Can you try these two simple programs to try to isolate
> > the error?
>
> > /* test1.c */
>
> > /* test2.c */
>
> Both test do hang (until doing something else in another terminal).
> test1 does *not* print a "Segmentation fault" message as it should
> (and does outside a uml machine).
>
> > The test as such will however (if not hanging) give a false positive if
> > UML is running within vmware and can be questioned unless complemented
> > with a UML test.
>
> The test seems to work correctly.  Probably it tries to access a "magic"
> i/o port which is used for communication between vmware and guest os,
> but I don't know for sure.
>
>   Gerd
>
> -- 
> You have a new virus in /var/mail/kraxel
>



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
