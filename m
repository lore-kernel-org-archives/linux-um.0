Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWfGa-00083r-7N for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 10:19:52 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CWfGZ-00088b-6Y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 10:19:52 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: 2.6.9-bb3 creates zombie threads in SKAS
References: <000901c4d0e1$e7f998d0$0201a8c0@hawk>
	<200411222346.36960.blaisorblade_spam@yahoo.it>
	<001001c4d184$ca00b9f0$0201a8c0@hawk>
In-Reply-To: <001001c4d184$ca00b9f0$0201a8c0@hawk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411231922.17600.blaisorblade_spam@yahoo.it>
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
Date: Tue, 23 Nov 2004 19:22:17 +0100
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Tuesday 23 November 2004 18:49, Christopher S. Aker wrote:
> > On Monday 22 November 2004 23:23, Christopher S. Aker wrote:
> > > Hello,
> >
> > Btw, question: what about your I/O token limiter? Actively using it?
> > Could start being worked on for merge (there is at least one bug-report
> > on it by "roland" on a strange but valid test-case).
> >
> > > I thought I'd give 2.6.9-bb3 a shot, and I had a bunch of users report
> > > the accumiluation of zombies.
> >
> > What the hell! This should *not* happen. What did we (I mean developers)
> > do?
>
> Just to be clear, these were zombies *inside* UML, not on the host.
*Inside*? Well, this is *VERY* different from what we were understanding. And 
nobody checked something like that...
> I'm 
> happy to blame it on the older SKAS version.
I'm not, unless your sentence mean that you have a test server on which you 
verified this is true... and even in that case, it can mean that this bug 
shows on hosts not supporting SYSEMU (like SKAS3/2.6-v1 hosts). Which would 
be anyway a bug.

And UML *should* be happy even without SYSEMU (if not for anything else, 
because you can pass "nosysemu" to it).
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
