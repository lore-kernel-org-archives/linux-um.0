Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2GDk-0007W3-0R
 for linux-um@lists.infradead.org; Wed, 20 Jan 2021 16:20:36 +0000
Subject: Re: [PATCH] init/module: split CONFIG_CONSTRUCTORS to fix module gcov
 on UML
References: <20210119121853.4e22b2506c9a.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
 <8191aa4a-3bd7-5de7-1ad2-73b851128ff3@linux.ibm.com>
 <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
From: Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <1232adfb-cbe8-5cfc-88bc-b8913d6a39c6@linux.ibm.com>
Date: Wed, 20 Jan 2021 17:20:25 +0100
MIME-Version: 1.0
In-Reply-To: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>

On 20.01.2021 17:09, Johannes Berg wrote:
> On Wed, 2021-01-20 at 17:07 +0100, Peter Oberparleiter wrote:
> 
>> Do you expect other users for these new config symbols? 
> 
> Probably not.
> 
>> If not it seems
>> to me that the goal of enabling module constructors for UML could also
>> be achieved without introducing new config symbols.
> 
> Yeah, true.
> 
>> For example you could suppress calling any built-in kernel constructors
>> in case of UML by extending the ifdef in do_ctors() to depend on both
>> CONFIG_CONSTRUCTORS and !CONFIG_UML (maybe with an explanatory comment).
>>
>> Of course you'd still need to remove the !UML dependency in
>> CONFIG_GCOV_KERNEL.
> 
> Right.
> 
> I can post a separate patch and we can see which one looks nicer?

Sounds good!


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

