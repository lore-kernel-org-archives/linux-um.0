Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKtqA-0000jE-Gf for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 00:27:58 -0700
Received: from plam.fujitsu-siemens.com ([217.115.66.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CKtq8-00051B-NT for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 22 Oct 2004 00:27:58 -0700
Message-ID: <4178B7CD.1010604@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Bad handling of invalif systemcalls
References: <4177D503.2030409@fujitsu-siemens.com>
	<200410211932.11392.blaisorblade_spam@yahoo.it>
In-Reply-To: <200410211932.11392.blaisorblade_spam@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 22 Oct 2004 09:33:33 +0200
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

BlaisorBlade wrote:
> 
> The first remark (the only I have for now) is that you should replace "SIGTRAP 
> + 0x80" with "SIGTRAP | 0x80". It should not make a difference in this 
> particular case, but it's a style issue, which exists because the second way 
> is more robust for setting bits: think about (SIGTRAP & 0x80) == 0x80 and 
> using the + 0x80: it clears the bit it should set and set another one.
Yes. I agree.

> 
> Remark no. 2: could you, please, in next patches, try to add -p to diff flags 
> to improve readability? That makes clear which function is being changed, so 
> the patch becomes more readable.
I will do so.

> 
>>For the third patch I'm quite anxious, that there could go something
>>wrong when using the debugger. I don't understand much about this.
>>Maybe someone else could look into this?
> 
> I'll give a look when I have the needed time. However, could you explain what 
> makes you worry in detail?
I do not understand, how the debugger works. I didn't even use it, yet.
Maybe it would be a good idea to learn while testing.
I tried to mask the additional 0x80 when the debugger is called
(i.e. "(status&0x7fff)"). But I don't know, whether this is the only place, where
a special handling has to be inserted to let the debugger see no changes.

Bodo


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
