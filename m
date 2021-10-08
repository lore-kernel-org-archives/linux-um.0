Return-Path: <rdunlap@infradead.org>
Subject: Re: [PATCH] PCI: vmd: depend on !UML
References: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
 <a8905276-7b46-cc50-740f-b9d86ec54717@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <613ef347-cafe-8b4e-ed89-8730aad4d6ef@infradead.org>
Date: Fri, 8 Oct 2021 14:37:43 -0700
MIME-Version: 1.0
In-Reply-To: <a8905276-7b46-cc50-740f-b9d86ec54717@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: "Derrick, Jonathan" <jonathan.derrick@intel.com>, Johannes Berg <johannes@sipsolutions.net>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "Berg, Johannes" <johannes.berg@intel.com>
List-ID: <linux-um.lists.infradead.org>

On 8/11/21 7:43 AM, Derrick, Jonathan wrote:
> Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Bjorn, can you merge this, please?
or did you expect it to be merged somewhere else?

thanks.

> On 8/11/2021 8:25 AM, Johannes Berg wrote:
>> From: Johannes Berg <johannes.berg@intel.com>
>>
>> With UML having enabled (simulated) PCI on UML, VMD breaks
>> allyesconfig/allmodconfig compilation because it assumes
>> it's running on X86_64 bare metal, and has hardcoded API
>> use of ARCH=x86. Make it depend on !UML to fix this.
>>
>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>> ---
>>   drivers/pci/controller/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 64e2f5e379aa..297bbd86806a 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -257,7 +257,7 @@ config PCIE_TANGO_SMP8759
>>   	  config and MMIO accesses.
>>   
>>   config VMD
>> -	depends on PCI_MSI && X86_64 && SRCU
>> +	depends on PCI_MSI && X86_64 && SRCU && !UML
>>   	tristate "Intel Volume Management Device Driver"
>>   	help
>>   	  Adds support for the Intel Volume Management Device (VMD). VMD is a
>>


-- 
~Randy

