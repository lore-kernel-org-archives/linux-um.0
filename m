Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cf61g-0004mt-D6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 16:31:20 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cf61f-0006Mj-GS for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Dec 2004 16:31:20 -0800
From: Paolo Giarrusso <blaisorblade_personal@yahoo.it>
Subject: Re: [uml-devel] unable to unmount tmpfs problem lives on
References: <000601c4e3cc$119a1280$0201a8c0@hawk>
	<200412170115.15731.blaisorblade_personal@yahoo.it>
	<001e01c4e3ce$c873fff0$0201a8c0@hawk>
In-Reply-To: <001e01c4e3ce$c873fff0$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412170130.13717.blaisorblade_personal@yahoo.it>
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
Date: Fri, 17 Dec 2004 01:30:13 +0100
To: "Christopher S. Aker" <caker@theshore.net>
Cc: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

On Friday 17 December 2004 01:24, Christopher S. Aker wrote:
> > Well, this is yet undiagnosed, but definitely it's not a UML bug... you
> > should certainly run a 2.6.8.1 based kernel...
>
> That is unfortunate.
>
> > There is some kind of security bug fixed in 2.6.9, but it was a littler
> > one probably (an overflow when handling file position...).
> >
> > Do you remember when UML crashed and left the unkillable 'D' thread?
> > That's a local DoS bug, and this one you're speaking about is a worse
> > one... I and Bodo have complained about this one (not on LKML) and didn't
> > get any answer yet...
>
> I could try and get a response from LKML, but you would probably present
> the problem better...
I've been away from the net one week, and I've posted the message before it. 
Now, I *do* want to wait before posting to LKML... I'll maybe complain 
louder. I'll post to LKML as a last resort, if they show not enough care of 
the problem, to urge them to fix it.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
