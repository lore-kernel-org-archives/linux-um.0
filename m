Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CEXaA-0008C4-Le for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 11:29:10 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CEXWq-0004NY-90 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 Oct 2004 11:29:08 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] T-mode processes
References: <29246.1096763190@marajade.sandelman.ottawa.on.ca>
	<Pine.LNX.4.61.0410031940080.16875@filer.marasystems.com>
	<30745.1096828767@marajade.sandelman.ottawa.on.ca>
In-Reply-To: <30745.1096828767@marajade.sandelman.ottawa.on.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410042022.22838.blaisorblade_spam@yahoo.it>
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
Date: Mon, 4 Oct 2004 20:22:22 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Michael Richardson <mcr@sandelman.ottawa.on.ca>, Henrik Nordstrom <uml@hno.marasystems.com>

On Sunday 03 October 2004 20:39, Michael Richardson wrote:
> >>>>> "Henrik" == Henrik Nordstrom <uml@hno.marasystems.com> writes:

>
>     Henrik> Any way, sending a SIGCONT to the stopped process gets it
>     Henrik> going again, or killed in case a SIGKILL or other terminal
>     Henrik> action is pending.
>
>   Our test bed produces a dozen of these every night.
>   If someone has an idea on how to get better intel on this, I'm happy
> to cooperate.
If you want to change the behaviour on such a point, you should convince 
top-level hackers on the LKML. Quite frankly, I guess that they will say 
'NO'; and they will add "Who ever said that SIGKILL always works?". And if Al 
Viro reads your post, his answer could be very bad (Al Viro is famous for the 
way he flames newbie kernel hackers).

That said, this just means you need to fix the automated reaper. Changing this 
in the SKAS patch is not an option (I don't have time to describe this). Even 
because I think the behaviour is correct, and it's hard to change that.

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
