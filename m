Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWeVq-0002Wa-C6 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 09:31:34 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CWeVo-0008Aa-B7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 09:31:34 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: WS lag
References: <41A060D2.1030802@alexb.ch> <172427175.20041122225013@surbl.org>
	<Pine.LNX.4.58.0411230209240.3317@sparrow>
In-Reply-To: <Pine.LNX.4.58.0411230209240.3317@sparrow>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200411231833.02752.blaisorblade_spam@yahoo.it>
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
Date: Tue, 23 Nov 2004 18:33:02 +0100
Content-Transfer-Encoding: 8bit
To: user-mode-linux-devel@lists.sourceforge.net, William Stearns <wstearns@pobox.com>
Cc: Jeff Chan <jeffc@surbl.org>, Alex Broens <surbl@alexb.ch>

On Tuesday 23 November 2004 08:17, William Stearns wrote:
> Good morning, all,

>  (For the UML-devel mailing list: The "spamgate" virtual machine
> creates multiple text files and stores them on the host via a hostfs
> mount.  The slartibartfast and jeeves VM's publish that data read through
> a hostfs mount out via http and rsync, respectively.)

>  The three vm's were publishing just fine in the 2.4.23 kernel I
> have at http://www.stearns.org/uml/ .  When I rebooted the three vm's into
> the 2.4.27 kernel I have there, slart and jeeves started showing stale
> data.  Moving spamgate back to 2.4.23 didn't help; slart and jeeves still
> presented old files to the outside world.  As soon as I moved slart and
> jeeves back to 2.4.23, the problems went away.
>  Kernels and compile options used are both at
> http://www.stearns.org/uml/ .

From the common experience, having hostfs working is a luck, with kernels 
later than 2.4.24-1um.

2.4.27-1bs (on my page) excludes all hostfs changes, while merging everything 
else up to 2.4.26-3um, plus some other changes.

Also, there are some unconfirmed results that NFS may be _faster_ than hostfs 
- so you might want to experiment this.
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
