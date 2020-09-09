Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kG5uX-0006zZ-6q
 for linux-um@lists.infradead.org; Wed, 09 Sep 2020 19:37:42 +0000
Subject: Re: [PATCH] docs: add a new User Mode Linux HowTo
References: <20200904141115.15708-1-anton.ivanov@cambridgegreys.com>
 <20200909115203.7c898211@lwn.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <14181df1-60a4-530e-e7f2-df4e1a2972a1@cambridgegreys.com>
Date: Wed, 9 Sep 2020 20:37:35 +0100
MIME-Version: 1.0
In-Reply-To: <20200909115203.7c898211@lwn.net>
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
To: Jonathan Corbet <corbet@lwn.net>
Cc: richard@nod.at, linux-um@lists.infradead.org, linux-doc@vger.kernel.org

On 09/09/2020 18:52, Jonathan Corbet wrote:
> On Fri,  4 Sep 2020 15:11:15 +0100
> anton.ivanov@cambridgegreys.com wrote:
> 
>> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>>
>> The new howto migrates the portions of the old howto which
>> are still relevant to a new document, updates them to linux 5.x
>> and adds documentation for vector transports and other new
>> features.
>>
>> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> Thanks for improving the docs!  Some nits...
> 
>>   .../virt/uml/user_mode_linux_howto_v2.rst     | 1304 +++++++++++++++++
>>   1 file changed, 1304 insertions(+)
>>   create mode 100644 Documentation/virt/uml/user_mode_linux_howto_v2.rst
> 
> You need to add this to an index.rst file so it becomes part of the docs
> build.

This has been done in v2.

> 
>> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> new file mode 100644
>> index 000000000000..3bcdd3aaebb5
>> --- /dev/null
>> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
>> @@ -0,0 +1,1304 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +#########
>> +UML HowTo
>> +#########
> 
> Please follow the markup conventions described in
> Documentation/doc-guide/sphinx.rst.
> 
>> +:Author:  User Mode Linux Core Team
>> +:Last-updated: Friday Sep 04 14:50:55 BST 2020
> 
> This isn't needed, that information is in the git commit history.

Ack. I will remove it from v3.

> 
> [...]
> 
>> +Why Would I Want User Mode Linux?
>> +=================================
>> +
>> +
>> +1. If User Mode Linux kernel crashes, your host kernel is still fine. It
>> +   is not accelerated in any way (vhost, kvm, etc) and it is not trying to
>> +   access any devices directly.  It is, in fact, a process like any other.
>> +
>> +#. You can run a usermode kernel as a non-root user (you may need to
>> +   arrange appropriate permissions for some devices).
> 
> Please don't use the "#." notation.  Remember that we want the docs to be
> just as readable in plain-text format.  If the enumeration (as opposed to
> just bullets) is really needed, it's needed in plain text too.
> 
>> +#. You can run a very small VM with a minimal footprint for a specific
>> +   task (f.e. 32M or less).
> 
> [...]
> 
>> +Creating an image
>> +=================
>> +
>> +Create a sparse raw disk image:
>> +
>> +.. code-block:: shell
>> +
>> +    dd if=/dev/zero of=disk_image_name bs=1 count=1 seek=16G
> 
> I'd honestly do without all these code-block directives as well; they
> clutter things considerably for little advantage.

I can merge most of these into a couple of code snippets. I would like 
to leave the content though. As UML does not have an official installer, 
the only way to install it is to build images and there is not that much 
information on this on the net. The only well written piece on the 
subject is > 10 years old and becoming a bit out of date.

> 
> [...]
> 
>> +*************************
>> +Setting Up UML Networking
>> +*************************
>> +
>> +UML networking is designed to emulate an Ethernet connection. This
>> +connection may be either a point-to-point (similar to a connection
>> +between machines using a back-to-back cable) or a connection to a
>> +switch. UML supports a wide variety of means to build these
>> +connections to all of: local machine, remote machine(s), local and
>> +remote UML and other VM instances.
>> +
>> +.. csv-table:: Supported Transports
>> +   :header: "Transport", "Type", "Capabilities", "Speed (on 3.5GHz Ryzen)"
>> +   :widths: 20, 10, 30, 20
>> +
>> +    "tap", "vector", "checksum and tso offloads", "> 8Gbit"
>> +    "hybrid", "vector", "checksum and tso offloads, multipacket rx", "> 6GBit"
>> +    "raw", "vector", "checksum and tso offloads, multipacket rx, tx", "> 6GBit"
>> +    "Ethernet over gre", "vector", "multipacket rx, tx", "> 3Gbit"
>> +    "Ethernet over l2tpv3", "vector", "multipacket rx, tx", >" 3Gbit"
> 
> This is nearly unreadable in the plain text; please use a normal RST table
> for this.

Ack. I will address that in the next version.

> 
> [...]
> 
>> +If the channel specification contains two parts separated by comma, the first one
>> +is input, the second one output.
>> +
>> +1. The null channel - Discard all input or output. Example ``con=null`` will set all consoles to null by default.
> 
> Please stick to the 80-column limit, it really does affect the readability
> of the text.

v2 addresses that.

> 
> Thanks,
> 
> jon
> 

Brgds,


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

