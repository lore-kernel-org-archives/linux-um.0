Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DsN1q-00083b-LU	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 08:50:38 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.44)
	id 1DsN1p-0003A8-9l	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 12 Jul 2005 08:50:38 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Problems about fork-not-clone (was: Re:
	[uml-user] UML exits after "tracing thread pid")
References: <1119527920.4679.15.camel@FC3-bernhard-1.acousta.local>
	<200507120304.58283.rob@landley.net>
	<1121160835.4718.3.camel@FC3-bernhard-1.acousta.local>
In-Reply-To: <1121160835.4718.3.camel@FC3-bernhard-1.acousta.local>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507121757.55572.blaisorblade@yahoo.it>
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
Date: Tue, 12 Jul 2005 17:57:55 +0200
To: user-mode-linux-user@lists.sourceforge.net, schauer@acousta.at
Cc: Rob Landley <rob@landley.net>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Tuesday 12 July 2005 11:33, Bernhard Schauer wrote:
> > Checking PROT_EXEC mmap in /tmp...OK
> > tracing thread pid = 11687
> >
> > And then exits with no further explanation or printout.
>
> That sounds like the behaviour described in the first message. If you
> apply the
> "uml-revert-fork-instead-of-clone.patch" posted by Blaisorblade in the
> same thread on 2nd July, everything should work as expected with TT mode
> only.
Exact, that's included in -bs which is included in the -skas0 patchset, so 
this is the explaination.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
