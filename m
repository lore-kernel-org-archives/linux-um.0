Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B2Aqt-0005Ld-15 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 07:15:03 -0800
Received: from 66-95-121-230.client.dsl.net ([66.95.121.230] helo=mail.lig.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B2AqU-0005l9-NN for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 13 Mar 2004 07:14:38 -0800
Message-ID: <405324DB.3030404@lig.net>
From: "Stephen D. Williams" <sdw@lig.net>
MIME-Version: 1.0
Subject: Re: [uml-devel] /dev/random oddity
References: <20040313014957.GB13419@speedy.schwinge.homeip.net>
	<405309FE.6020603@darkman.de>
In-Reply-To: <405309FE.6020603@darkman.de>
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
Date: Sat, 13 Mar 2004 10:12:27 -0500
To: Sven 'Darkman' Michels <sven@darkman.de>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a bit beyond our scope here, but one ideal source for randomness 
is LavaRnd: http://www.lavarnd.org/

If you set that up and run trickle, it will stock /dev/random with some 
true randomness.  I'm not sure why they apparently didn't increase 
"/dev/random's vague notion of the amount of entropy available" since 
lavarnd can generate so much random data quickly.  That should be fixed 
as far as I can see.

Getting this working with UML, and in fact feeding multiple UMLs with 
high quality random data, would be very useful.

Related to this would be multiplexing PKI smart cards and HSMs accross 
multiple UMLs.  I'm going to need this soon.

sdw

Sven 'Darkman' Michels wrote:

> Thomas Schwinge wrote:
>
>> On UML the entropy pool seems never to be refilled - not matter how long
>> I keep a key pressed; I don't have a mouse there - so AFAICT /dev/random
>> stops working at the time the pool gets empty.
>
>
> never is wrong, you can 'fill' the pool by doing some work like find /
> ps aux etc, but this is really slow in filling up the pool. Maybe
> other things should be used to fill the pool, too. Jeff? Blaisor?
> anyone? ;)
>
> Regards,
> Sven
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel



-- 
swilliams@hpti.com http://www.hpti.com Personal: sdw@lig.net http://sdw.st
Stephen D. Williams 703-724-0118W 703-995-0407Fax 20147-4622 AIM: sdw



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
