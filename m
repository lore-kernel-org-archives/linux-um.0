Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPNt4-0002Gh-WE for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:21:31 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CPNt4-0006u8-5a for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Nov 2004 08:21:30 -0800
From: Blaisorblade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] uml_mconsole
References: <267988DEACEC5A4D86D5FCD780313FBB0161AF57@exch-03.noida.hcltech.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB0161AF57@exch-03.noida.hcltech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411031721.45025.blaisorblade_spam@yahoo.it>
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
Date: Wed, 3 Nov 2004 17:21:44 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: "Adil Mujeeb, Noida" <adilm@hcltech.com>, user-mode-linux-user@lists.sourceforge.net

On Wednesday 03 November 2004 07:53, Adil  Mujeeb, Noida wrote:
> Hi,
> iam using uml_mconsole. i want to configure or see th configuration of
> interface device on UML.
> when i issue command on uml console config eth0, it gives error message
> "ERR No get_config routine defined"
>
> Can anyone throw some lights on this case whats wrong here?
>
> Thanks and Best Regards,
> Adil Mujeeb
Yes, I know that, not yet had time to fix this. Simply a piece of code should 
be written to support ethernet configuration. "config eth#n" is easy; "config 
eth#n=...." is a bit harder, but should be possible anyway.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
