Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FgRQn-0003bt-1k for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 12:11:37 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FgRQl-0006Sj-La
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 17 May 2006 12:11:36 -0700
Message-ID: <446B7563.2040203@theshore.net>
From: "Christopher S. Aker" <caker@theshore.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] Kernel mode fault at addr 0x87800000, ip 0x400007b0
References: <44619F72.7060009@theshore.net>
	<20060515034813.GF21383@ccure.user-mode-linux.org>
In-Reply-To: <20060515034813.GF21383@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 17 May 2006 14:11:31 -0500
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

Jeff Dike wrote:
> On Wed, May 10, 2006 at 03:08:18AM -0500, Christopher S. Aker wrote:
>> 2.6.16 + bb1
>>
>> Kernel panic - not syncing: Kernel mode fault at addr 0x87800000, ip 
>> 0x400007b0
>>
>> EIP: 0073:[<400007b0>] CPU: 0 Not tainted ESP: 007b:bfe19380 EFLAGS: 
>> 00000212
>>     Not tainted
>> EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
>> ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 007b ES: 007b
>> 87163704:  [<80053225>] notifier_call_chain+0x27/0x3e
>> 87163720:  [<80040ebb>] panic+0x70/0x102
>> 87163738:  [<8001ea71>] segv+0x292/0x2c0
>> 87163794:  [<80022cd6>] fix_range+0x46/0x4a
>> 87163804:  [<8001e7a0>] segv_handler+0xa5/0xe4
>> 87163828:  [<8001e6fb>] segv_handler+0x0/0xe4
>> 8716382c:  [<80033ef6>] sig_handler_common_skas+0x92/0xe1
>> 8716384c:  [<8002fd7e>] sig_handler+0x62/0x6d
>> 87163860:  [<8038fbf8>] __restore+0x0/0x8
>> 871638a0:  [<80254a39>] vsnprintf+0x343/0x4de
>> 871638c4:  [<800319f1>] setjmp_wrapper+0x36/0x85
>> 87163950:  [<80023073>] buffer_op+0x47/0x77
>> 87163954:  [<80022eda>] do_buffer_op+0x0/0x152
> 
> I don't suppose this is reproducable?  

Not that I know of.

> If you have the UML kernel that did this, can you disassemble
> setjmp_wrapper and send that to me?

I would, if I had the skillz.  Here's the binary:

http://www.theshore.net/~caker/uml/kernels/2.6.16.1-linode18

-Chris



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
