Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DC0Qd-0005rv-3b for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 11:13:07 -0800
Received: from server.ispbrasil.com.br ([66.160.135.36] helo=ispbrasil.com.br)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1DC0Qb-0003G9-97
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Mar 2005 11:13:07 -0800
Message-ID: <000501c52b25$717710e0$0201a8c0@lualele>
From: "itamar" <itamar@ispbrasil.com.br>
References: <000d01c52b22$8ab2c020$0201a8c0@lualele>
	<20050317190007.GA15341@taniwha.stupidest.org>
Subject: Re: [uml-devel] Re: [uml-user] uml help __alloc_pages: 0-order
	allocation failed (gfp=0xf0/0)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
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
Date: Thu, 17 Mar 2005 16:13:37 -0300
To: Chris Wedgwood <cw@f00f.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

In the host I have 512 mb of ram

I am running the guest kernel with mem=256M


Itamar Reis Peixoto
+55 (34) 3238 3845
e-mail : itamar@ispbrasil.com.br
http://vps.ispbrasil.com.br
> 
>> I am running a uml machine, and I am getting this errors.
>> 
>> __alloc_pages: 0-order allocation failed (gfp=0xf0/0)
>> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
>> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
> 
> add more memory
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
