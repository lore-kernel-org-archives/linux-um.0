Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CnzrB-0001e9-BD for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 05:45:17 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1Cnzr5-0002MN-4v for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 05:45:16 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<Pine.LNX.4.61.0501100141480.14613@filer.marasystems.com>
	<200501100134.05591.rob@landley.net>
In-Reply-To: <200501100134.05591.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501101447.11835.blaisorblade@yahoo.it>
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
Date: Mon, 10 Jan 2005 14:47:11 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Rob Landley <rob@landley.net>, Henrik Nordstrom <uml@hno.marasystems.com>, Frank Sorenson <frank@tuxrocks.com>

On Monday 10 January 2005 07:34, Rob Landley wrote:
> On Sunday 09 January 2005 08:53 pm, Henrik Nordstrom wrote:
> > On Sun, 9 Jan 2005, Rob Landley wrote:
> > > I wonder if that old hack (deleting the file signalling there's no rush
> > > about writing stuff back to the disk anymore, although it's still your
> > > backing store) still works?
> >
> > Probably not.
>
> Might be worth a shot, though.  (If I delete the file from userspace after
> launching UML, will it screw up anything?)
You won't be able to delete it, because UML deletes the file by itself...

(See my other mail for more details).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
