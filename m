Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iATlX-0004dA-Tu
 for linux-um@lists.infradead.org; Wed, 18 Sep 2019 06:48:42 +0000
Subject: Re: CONFIG_COMPAT for UM?
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
References: <60f73376da11640d5b335512f052a583fd784fd8.camel@sipsolutions.net>
 <76d688c3-3d8b-fb59-3ad4-ef8dd9c023be@kot-begemot.co.uk>
Message-ID: <b3507d24-ebd9-8e7f-25a8-61c1891c37d4@kot-begemot.co.uk>
Date: Wed, 18 Sep 2019 07:48:30 +0100
MIME-Version: 1.0
In-Reply-To: <76d688c3-3d8b-fb59-3ad4-ef8dd9c023be@kot-begemot.co.uk>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org

On 17/09/2019 22:54, Anton Ivanov wrote:
> 
> 
> On 17/09/2019 21:47, Johannes Berg wrote:
>> Hi,
>>
>> It seems to me that it ought to be possible - at least if the host
>> kernel has 32/64 compatibility, to extend the same to the UML kernel?
>>
>> Has anyone ever given this a thought?
>>
>> I just realized that our test suite is based on 32-bit binaries ... :-)
>>
>> johannes
>>
>>
>> _______________________________________________
>> linux-um mailing list
>> linux-um@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-um
>>
> 
> I have run 32 on 64 with no issues. In fact, I had to build a product 
> prototype using that a while back because the target userspace load did 
> not have 64 bit support. Even vector IO works despite the differences 
> between 32 bit and 64 bit syscalls for that.
> 
> I am not sure we need to do anything here. What in particular do you 
> have in mind?
> 

Sorry, not thinking. Serves me right answering mails at 11pm.

I was thinking about running 32 bit instances on a 64 bit host.

Pure 32 bit userspace on 64 kernel - yeah... why not. Though to be 
honest, nearly all distributions now have multiarch support so the need 
for this is nowhere near as pressing as 10+ years ago when the first 
AMD64 processors came out.

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

