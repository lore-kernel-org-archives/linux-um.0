Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6DPs-0003tu-A7 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Mar 2005 11:52:24 -0800
Received: from nexus.iu.hio.no ([128.39.89.10])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6DPp-0003S7-Mc for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 01 Mar 2005 11:52:24 -0800
From: Kyrre M Begnum <Kyrre.Begnum@iu.hio.no>
Subject: Re: [uml-devel] 2.6.10 command line longer than 512 characters 
In-Reply-To: <200503012137.j21LagMY009262@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.62.0503012048120.6406@cube.iu.hio.no>
References: <Pine.LNX.4.58.0501071105351.22595@cube.iu.hio.no> 
	<200503012137.j21LagMY009262@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 1 Mar 2005 20:51:55 +0100 (MET)
To: Jeff Dike <jdike@addtoit.com>
Cc: Kyrre M Begnum <Kyrre.Begnum@iu.hio.no>, user-mode-linux-devel@lists.sourceforge.net


Thank you, i got a reply on that a while ago pointing me to a patch of 
that kind. I am gratefull for the follow-up though. If i may ask, is the 
patch on its way into 2.6.11? Blaisorblade mentioned it being on his list 
somewhere.

>> I have noticed that when I supply a command line longer than 513
>> characters (or was it 512?) the kernel crashes. Output supplied at the
>> end of mail. This does not seem to be a problem on the old 2.4.24
>> guest kernels. Is there a way I can change this, perhaps during kernel
>> configuration?
>
> This is fixed in my long-command-line patch.
>
> 				Jeff



>
>

---------------------
Kyrre M Begnum
Rom 1.755 7.etg
Tfl: 22453276


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
