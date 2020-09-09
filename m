Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH] docs: add a new User Mode Linux HowTo
References: <20200904141115.15708-1-anton.ivanov@cambridgegreys.com>
 <20200909115203.7c898211@lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a0ce0897-fb78-0537-ea49-190fe2cc0736@infradead.org>
Date: Wed, 9 Sep 2020 10:54:44 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jonathan Corbet <corbet@lwn.net>, anton.ivanov@cambridgegreys.com
Cc: richard@nod.at, linux-um@lists.infradead.org, linux-doc@vger.kernel.org

On 9/9/20 10:52 AM, Jonathan Corbet wrote:
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
>>  .../virt/uml/user_mode_linux_howto_v2.rst     | 1304 +++++++++++++++++
>>  1 file changed, 1304 insertions(+)
>>  create mode 100644 Documentation/virt/uml/user_mode_linux_howto_v2.rst
> 
> You need to add this to an index.rst file so it becomes part of the docs
> build. 

> [...]
> 
>> +If the channel specification contains two parts separated by comma, the first one
>> +is input, the second one output.
>> +
>> +1. The null channel - Discard all input or output. Example ``con=null`` will set all consoles to null by default.
> 
> Please stick to the 80-column limit, it really does affect the readability
> of the text.


BTW, Jon, there is a v2 of this patch (not saying that it addresses
any of your comments/concerns).


-- 
~Randy


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

