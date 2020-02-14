Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2bNj-0004DB-TY
 for linux-um@lists.infradead.org; Fri, 14 Feb 2020 13:51:49 +0000
Subject: Re: Documentation for UML Vector network
References: <7c37a3f7310c0be2202ada464e31c2d4d424c502.camel@researchut.com>
 <32d50bed-cfdb-288a-181c-e186143c8169@kot-begemot.co.uk>
 <44b7a3a49731dfabe9cdfbeb281ad9470e71b625.camel@researchut.com>
 <c6774e9e-7811-cbbb-eea5-83e5045b59e9@kot-begemot.co.uk>
 <41e0199cf2ad126bca3047d18e14493ab903bbe6.camel@researchut.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <f2e45b10-b4e9-e7d0-b6d9-153b086c46b0@kot-begemot.co.uk>
Date: Fri, 14 Feb 2020 13:51:41 +0000
MIME-Version: 1.0
In-Reply-To: <41e0199cf2ad126bca3047d18e14493ab903bbe6.camel@researchut.com>
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
To: rrs@researchut.com, linux-um@lists.infradead.org

On 14/02/2020 11:38, Ritesh Raj Sarraf wrote:
> Hi Anton,
> 
> On Wed, 2020-02-12 at 15:54 +0000, Anton Ivanov wrote:
>> In first instance I intend to update that. There is actually a .rd
>> markup version in progress for the next kernel versions.
>>
>> A wiki will be nice, because there is no way to fit all new UML
>> features like direct tunnel/overlay attachment, time travel, etc in
>> the documentation in the kernel tree.
> 
> A follow-up question.
> 
> The traditional UML networking modes supported slirp, which allowed for
> unprivileged networking access.
> 
> Is that something achievable with UML Vector network ?

If "completely unprivileged" networking is desired, it is achievable 
with an external slirp helper.

We may need to update UML utilities so it talks to an existing transport 
in UML (f.e. one of the unix domain socket ones).

Alternatively, if we are talking from a distro packaging perspective, I 
would suggest giving the UML binary raw socket capabilities the way 
tcpdump and wireshark postinst do it.

After that it can just hook up to a suitable interface in the system 
using raw sockets while running as unprivileged user.


> We have a use case where we want to be able be capable to use UML with
> network features. But do not have necessary privileges to set
> networking up on the host.
> 
> 

Brgds,


-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

