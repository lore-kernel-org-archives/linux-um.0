Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ChCZr-0002Uf-8h for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 11:55:19 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1ChCZq-0002k0-F6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 22 Dec 2004 11:55:19 -0800
Message-ID: <41C9D1F0.4000605@rimuhosting.com>
From: Peter <peter.repliesignored@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Memory corruption/errors?
References: <63806.222.152.52.159.1103583370.squirrel@222.152.52.159>
	<41C963DC.8060401@fujitsu-siemens.com>
In-Reply-To: <41C963DC.8060401@fujitsu-siemens.com>
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
Date: Thu, 23 Dec 2004 08:58:40 +1300
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I don't recall seeing an error where the obs and exp were equal.  I saw 
plenty where they were not equal.

The code is pretty simple:
double observed = a[i];
double expected = (double) i;
if (observed != expected) {
	      printf ("failed at i=%u, k=%u (obs %.18g vs exp %.18g)\n",i, 
k,observed, expected);
};

Maybe it is just some unexpected handling on the != operator with doubles?

Are you seeing cases where obs!=exp?  And difference if you run it on a 
uni-proc server vs. a smp server?

Regards, Peter

Bodo Stroesser wrote:
> Carl wrote:
> 
>> Hi,
>>
>> Running the piece of code from the URL below is generating errors on
>> various UML kernels:
>>
>> http://downloads.rimuhosting.com/memtest.c
>>
>> Kernels tested are: 2.4.27, 2.4.27-bs1, 2.6.9-bb4.
>>
>> Different UML host servers have been tried too, and only UMLs running on
>> SMP (dual Xeon) servers seem to have the problem (P4s with HT are fine).
>>
>> Can anyone else reproduce the errors? Any ideas?
>>
>> Thanks, Carl
Do you see messages like this one

     "failed at i=17240, k=85 (obs 17240 vs exp 17240)"

with obs and exp being equal?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
