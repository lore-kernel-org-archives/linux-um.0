Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Co31m-0004KX-Qt for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 09:08:26 -0800
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user40543)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Co31i-0003Xp-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 10 Jan 2005 09:08:24 -0800
Subject: Re: [uml-devel] How stable is hostfs (and UML in general)?
References: <200501082106.38306.rob@landley.net>
	<200501091706.58778.rob@landley.net>
	<Pine.LNX.4.61.0501100141480.14613@filer.marasystems.com>
	<200501100134.05591.rob@landley.net>
From: Nix <nix@esperi.org.uk>
In-Reply-To: <200501100134.05591.rob@landley.net> (Rob Landley's message of
	"Mon, 10 Jan 2005 01:34:05 -0500")
Message-ID: <87pt0d5i15.fsf@amaterasu.srvr.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
Date: Mon, 10 Jan 2005 17:08:06 +0000
To: Rob Landley <rob@landley.net>
Cc: Henrik Nordstrom <uml@hno.marasystems.com>, Frank Sorenson <frank@tuxrocks.com>, user-mode-linux-devel@lists.sourceforge.net

On Mon, 10 Jan 2005, Rob Landley yowled:
> On Sunday 09 January 2005 08:53 pm, Henrik Nordstrom wrote:
>> On Sun, 9 Jan 2005, Rob Landley wrote:
>> > I wonder if that old hack (deleting the file signalling there's no rush
>> > about writing stuff back to the disk anymore, although it's still your
>> > backing store) still works?
>>
>> Probably not.
> 
> Might be worth a shot, though.  (If I delete the file from userspace after 
> launching UML, will it screw up anything?)

UML does that itself.

-- 
`Blish is clearly in love with language. Unfortunately,
 language dislikes him intensely.' --- Russ Allbery


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
