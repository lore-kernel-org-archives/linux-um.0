Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNxVD-0007qP-0U for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:26:43 -0700
Received: from zcars04f.nortelnetworks.com ([47.129.242.57])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BNxV7-0004gN-VB for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 May 2004 10:26:38 -0700
Message-ID: <40A25E3E.9050502@nortelnetworks.com>
From: Joe Marzot <gmarzot@nortelnetworks.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: [uml-user] LTT in UML ?
References: <4098FC64.3000607@enterasys.com>
	<070c01c432f8$1a423000$2000000a@schlepptopp>
	<409AF27F.6020207@vgertech.com> <409FB190.4060006@enterasys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 12 May 2004 13:26:22 -0400
To: David Bahi <dbahi@enterasys.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

you are not the only one interested. There is a difference in what would 
be shown with tracing UML from the host vs. tracing the guest 
processes/kernel in a UML guest. I have the patches applied here as well 
but it does not look like it is working. let's keep in touch as we 
discover things.

regards, GSM

David Bahi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> right. yet, not what i was going for.
> i'd like to profile applications running
> under/within the uml itself.
> 
> still, looks like it's just me that's
> interested in this so i'll give it a go
> when i get a chance and post specific
> questions to this list when i'm lost.
> 
> - --
> db
> 
> Nuno Silva wrote:
> 
> | roland wrote:
> |
> | [..]
> |
> |  >
> |  > probably, having an LTT option for the uml-kernel could give some
> | benefit (performance optimization?)
> |  > for the uml project ?
> |  >
> |
> | You can do that already. Run LTT on the host and "trace" the UML
> | processes ;)
> |
> | Regards,
> | Nuno Silva
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.2.4 (MingW32)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFAn7GQ3XQ4zakZ3z4RApfJAJ4/95BNqYzt/uRWCPWPwHlozVBvrACfTkjH
> 2qU4ecl/5pHhbe0Pl+MfB+8=
> =yEiC
> -----END PGP SIGNATURE-----





-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
