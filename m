Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6ZzY-00015W-4j for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 11:58:44 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1D6ZzR-0005hK-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Mar 2005 11:58:44 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [uml-user] [PATCH] extend the limits for command
	line
References: <Pine.LNX.4.61.0411040859130.18123@webhosting.rdsbv.ro>
	<200411041534.31568.blaisorblade_spam@yahoo.it>
In-Reply-To: <200411041534.31568.blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200503022058.19484.blaisorblade@yahoo.it>
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
Date: Wed, 2 Mar 2005 20:58:19 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Blaisorblade <blaisorblade_spam@yahoo.it>, "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>, jdike@karaya.com, linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net

On Thursday 04 November 2004 15:34, Blaisorblade wrote:
> On Thursday 04 November 2004 08:08, Catalin(ux aka Dino) BOIE wrote:
> > Hello!
> >
> > (I resend this because I get no feedback.)

> Sorry, miss of time.
I'm doing it now... I'll post it soon for merging. The crash fixed by Jeff 
Dike in his patch is a different things: he fixes a buffer overflow, I 
cleanup things and increase cleanly the allowed cmdline size. The original 
Catalin BOIE's patch should work in the meanwhile.

> Also, I'd like to cross-check this patch with the one used by Knoppix for
> ages to do the same thing.
Still to find.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
