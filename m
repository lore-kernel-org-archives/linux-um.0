Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CJcC8-0003R5-Uo for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 11:25:20 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CJcC7-0000Ig-4d for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 18 Oct 2004 11:25:20 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
References: <415408E40001A675@ms001msg.mail.fw>
In-Reply-To: <415408E40001A675@ms001msg.mail.fw>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410181948.22460.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Re: [uml-user] UML on PPC? state of the art
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
Date: Mon, 18 Oct 2004 19:48:22 +0200
To: user-mode-linux-user@lists.sourceforge.net, stefano.melchior@fastwebnet.it
Cc: user-mode-linux-devel@lists.sourceforge.net

On Monday 18 October 2004 17:58, SteX wrote:
> Hi all,
> does anyone know if the porting of UML on PPC has still been staled? or
> anyone has started working on?
> My Apple Powerbook is crying! ((:-((

> I found something about the porting on Chris Emerson's home page, but it
> is staled sice july 2001!
Where's that page?
> Let me know.
>
> Thank you in advance
>
> Regards
>
> SteX
Nobody is working on the PPC port. If someone wants to start helping, we will 
welcome him. Currently, the interest in UML is increasing, new developers 
come in, and after a lot of time, a new architecture (x86_64) is being 
supported. Also we've seen messages from people starting work to port UML 
even to ARM machines(!). No actual code, yet, so I suppose they stopped.

However, nobody removed the old code from UML. It has even been accepted in 
the 2.6 kernel, even if it is completely broken.

If you can bring up this issue on any place where someone could pick it up, 
you could find someone helping.

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
