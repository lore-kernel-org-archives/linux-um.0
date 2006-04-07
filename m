Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FRmCR-0002fV-Co for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 01:20:11 -0700
Received: from nproxy.gmail.com ([64.233.182.185])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FRmCP-0000G0-Hz
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 07 Apr 2006 01:20:11 -0700
Received: by nproxy.gmail.com with SMTP id l24so231808nfc
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 07 Apr 2006 01:20:04 -0700 (PDT)
In-Reply-To: <20060406234248.GB6893@ccure.user-mode-linux.org>
References: <8F963598-0F1A-464A-991A-2FE95F9B418C@epfl.ch>
	<20060405181812.GA5684@ccure.user-mode-linux.org>
	<200604070220.01278.blaisorblade@yahoo.it>
	<20060406234248.GB6893@ccure.user-mode-linux.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D44F616D-1F3B-496E-A311-68CF5E5FC882@epfl.ch>
Content-Transfer-Encoding: 7bit
Subject: Re: [uml-devel] system call accessing the host os
From: Olivier Crameri <olivier.crameri@gmail.com>
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
Date: Fri, 7 Apr 2006 10:20:01 +0200
To: Jeff Dike <jdike@addtoit.com>
Cc: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net

Great, thanks a lot. Now I understand what's happening. It was  
actually calling um_vmalloc....

Olivier


On 7 avr. 06, at 01:42, Jeff Dike wrote:

> On Fri, Apr 07, 2006 at 02:20:00AM +0200, Blaisorblade wrote:
>> No, I made it "greater than 4k" in 2.4.24 time... in fact it's what's
>> happening to him (see his last mail):
>
> Oh yeah.  In that case, the memset thing I mentioned earlier might  
> help.
>
> 				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
