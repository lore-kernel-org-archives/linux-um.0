Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D96sT-0004ny-R8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:29:53 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D96sS-0006E1-4L for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 11:29:53 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] tun/tap network throughput problem
References: <3524bf1f05030712562d547e1c@mail.gmail.com>
In-Reply-To: <3524bf1f05030712562d547e1c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503092029.30119.blaisorblade@yahoo.it>
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
Date: Wed, 9 Mar 2005 20:29:29 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Young Koh <young.koh@gmail.com>

On Monday 07 March 2005 21:56, Young Koh wrote:
> Hi,
>
> i was running an expriment to measure network throughput of UML.
> physical machine A and B are connected with gigabit network. and UML
> runs on machine A. i'm sending bulk UDP packets from UML to machine B
> using ttcp network throughput benchmark program.
> i'm using 2.4.26 for both UML and host. (skas + sysemu patched)
>
> i modified UML kernel code to get high performance a little bit, and i
> got some gain with TCP and UDP throughput.
Hmm, can you share your changes with us, please? We'd be very grateful...
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
