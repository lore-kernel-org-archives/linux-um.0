Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D5bTL-00064y-Se for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Feb 2005 19:21:27 -0800
Received: from rproxy.gmail.com ([64.233.170.196])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D5bTL-0004f8-DS for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 27 Feb 2005 19:21:27 -0800
Received: by rproxy.gmail.com with SMTP id 34so65317rns
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 27 Feb 2005 19:21:23 -0800 (PST)
Message-ID: <a53adc4605022719217668da14@mail.gmail.com>
From: Scott Edwards <supadupa@gmail.com>
Reply-To: Scott Edwards <supadupa@gmail.com>
In-Reply-To: <267988DEACEC5A4D86D5FCD780313FBB04F72867@exch-03.noida.hcltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <267988DEACEC5A4D86D5FCD780313FBB04F72867@exch-03.noida.hcltech.com>
Subject: [uml-devel] Re: [uml-user] Telnet (IPV6) on port
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
Date: Sun, 27 Feb 2005 20:21:22 -0700
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Mon, 28 Feb 2005 08:37:33 +0530, Adil  Mujeeb, Noida
<adilm@hcltech.com> wrote:
>  
>   
> Reposting the question. 
> If there is any clarification required in the question, plz revert back. 
> 
> Thanks and Best Regards,
> Adil Mujeeb
> 
> From: user-mode-linux-user-admin@lists.sourceforge.net
> [mailto:user-mode-linux-user-admin@lists.sourceforge.net]On Behalf Of Adil
> Mujeeb, Noida
> Sent: Saturday, February 26, 2005 9:45 PM
> To: user-mode-linux-devel@lists.sourceforge.net;
> user-mode-linux-user@lists.sourceforge.net
> Cc: Mukul Prasad, Noida
> Subject: [uml-user] Telnet (IPV6) on port
> 
>  
>  
>  
> Hi, 
> Iam using 2.4.26 linux source and patch it with uml-patch-2.4.26-3 patch. 
> I have built the uml binary with ipv6 support and my host has ipv6 module
> loaded. 
> The telnet client and daemon are IPV6 supported on the Host machine. Iam
> able to telnet on the localhost with ipv6 address. 
> For example to telnet on localhost with loopback address ( ::1 ) , it works
> fine. 
>   
> Now Im running uml on this host (RedHat 9) with command as follows: 
>   
> ./linux ubd0=guest1.diff,root_fs con=port:9001 con0=fd:0,fd:1 umid=guest1
> mem=32m 
>   
> Now when i try to telnet on UML with following command : 
> telnet 127.0.0.1 9001, it works fine 
>   
> But if I telnet with : 
> telnet ::1 9001 
> it gives message connection refused. 
>  
>   
> Can anyone throw some light on it why this is happening??? 
>   
> Thanks and Best Regards,
> Adil Mujeeb
>  

Does netstat suggest an ipv6 port is listening?

eg, netstat -tanp (tcp, all ports in use/open, numerical only, list owning pid)

If that's not sufficient (I'm not using ipv6), use lsof as well.

Let us know!


Scott Edwards
-- 
Daxal Communications - http://www.daxal.com
Surf the USA - http://www.surfthe.us


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
