Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CCiNm-0002EC-9Q for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 10:36:50 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CCiNk-0006SM-LE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 29 Sep 2004 10:36:50 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: [Openswan CVS] openswan-2/linux/net/ipsec
	addrtot.c, 1.16, 1.17
References: <20040915214906.02A1F138028@tla.xelerance.com>
	<200409251915.25579.blaisorblade_spam@yahoo.it>
	<17531.1096224669@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <17531.1096224669@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409291934.08173.blaisorblade_spam@yahoo.it>
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
Date: Wed, 29 Sep 2004 19:34:08 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, CaT <cat@zip.com.au>, dev@lists.openswan.org

On Sunday 26 September 2004 20:51, Michael Richardson wrote:
> >>>>> "BlaisorBlade" == BlaisorBlade  <blaisorblade_spam@yahoo.it> writes:
>
>     BlaisorBlade> The problem is just the fact that
>     BlaisorBlade> "EXPORT_SYMBOL(strstr)" is commented out in THAT
>     BlaisorBlade> file. If you compile the code which uses that
>     BlaisorBlade> statically, it will work, so you're not on the right
>     BlaisorBlade> road.
>
>   Okay, can it be commented back in for 2.6.9?
It is already fixed in 2.6.9-rc2; I refer to the actual vanilla kernel, since 
the UML patch has been merged (actually from my own tree, so some things, as 
this one, have been fixed there before than in the Jeff's tree; however I 
*do* send the patches him, it's just sometimes they get lost).

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
